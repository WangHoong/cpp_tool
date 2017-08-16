class RevenueWorker
  include Sidekiq::Worker
  sidekiq_options queue: :revenue, retry: false


  def perform(revenue_id,user_id)
    revenue = Revenue.find(revenue_id)
    response = revenue.analyses_data(:succeed)
    time = revenue.analyses_date(:succeed)
    bucket = {}
    if response.blank?
       puts "not succeed data...."
       return false
    end
    start_date = Time.at(time['min_date']['value'] / 1000)
    end_date = Time.at(time['max_date']['value'] / 1000)

    response.each do |ele|
      next if ele['note']['provider_id'].nil?
      provider_id = ele['note']['provider_id']

      if bucket[provider_id].blank?
        bucket[provider_id] = []
      end

      bucket[provider_id] << ele
    end

    res = {}
    file = {}
    file = gen_settlement_workbook(bucket, start_date, end_date)

    file.each do |key, value|
      url, err = UploadUtil.upload('settlements', value.to_stream)
      res[key] = [url , err]
    end

    info = {}
    currency = Currency.first
    bucket.each do |key, value|
      amount = 0
      info['provider_id'] = key
      info['currency_id'] = currency.id
      info['dsp_id'] = value[0]['note']['dsp_id']
      info['file_url'] = res[key][0]

      value.each do |row|
        amount += row['note']['income'].to_f
      end

      info['settlement_amount'] = amount
      info['settlement_cycle_start'] = start_date
      info['settlement_cycle_end'] = end_date

      @settlement = Cp::Settlement.new(info)
      @settlement.settlement_date = Date.today
      @settlement.user_id = user_id
      if @settlement.save
        @settlement.payment_transations
        revenue.finished!
      end
    end
  end


  private
  def gen_settlement_workbook(bucket, start_date, end_date)
    res = {}
    bucket.each do |key, value|
      provider = get_provider(key)
      currency = Currency.first

      res[key] = Axlsx::Package.new do |p|
        sheet_name = "详情表"
        sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
        sheet.add_row ['RevenueStart', 'RevenueEnd', 'Year', 'Month', 'Day', 'PropertyID', 'DSP','ISRC', 'UPC', 'OwnerPropertyID', 'LabelName', 'Title', 'Artist', 'Album', 'TypeOfSales', 'SalesUnit', 'Total', 'Currency', 'ExchangeRate', 'AmountDue']

        value.each do |row|
          sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
          sheet.add_row build_detail_row(row, start_date, end_date).values
        end

        set = {}
        sheet_name = "数据汇总"
        sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
        sheet.add_row ['CP名称', provider.try(:name)]
        sheet.add_row ['结算货币', currency.try(:name)]
        sheet.add_row ['DSP', 'DateStart', 'DateEnd','TypeOfSales','SalesUnit','Total', 'Currency', 'ExchangeRate', 'AmountDue' ]

        value.each do |row|
          type = row['data']['sales_type']
          if set[type].blank?
            set[type] = (row['note'].slice('dsp_name', 'start_date', 'end_date', 'income').merge! row['data'].slice('sales_type','sales_unit', 'exchange_rate'))
            next
          end
          set[type]['income'] += row['note']['income']
        end

        set.each do |key, value|
          sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
          sheet.add_row build_info_row(key, value, start_date, end_date).values
        end
      end
    end

    res
  end

  def find_or_create_sheet_by_name(workbook, name)
    sheet = workbook.sheet_by_name(name)
    sheet = workbook.add_worksheet(name: name) if sheet.blank?

    sheet
  end

  def get_provider(provider_id)
    provider = Provider.find(provider_id) rescue nil

    provider
  end


  def build_detail_row(row, start_date, end_date)
    dataset = {}
    date = row['note']['start_date'].try(:to_datetime)

    dataset['RevenueStart'] = start_date
    dataset['RevenueEnd'] = end_date
    dataset['Year'] = date && date.strftime('%Y')
    dataset['Month'] = date && date.strftime('%m')
    dataset['Day'] = date && date.strftime('%d')
    dataset['OwnerPropertyID'] = 'null'
    dataset['DSP'] = row['note']['dsp_name']
    dataset['ISRC'] = row['data']['isrc']
    dataset['UPC'] = row['data']['upc']
    dataset['PropertyID'] = row['note']['track_id']
    dataset['LabelName'] = row['note']['provider_name']
    dataset['Title'] = row['data']['title']
    dataset['Artist'] = row['data']['artist']
    dataset['Album'] = row['data']['album']
    dataset['TypeOfSales'] =  row['data']['sales_type']
    dataset['SalesUnit'] =  row['data']['sales_unit']
    dataset['Total'] = row['note']['income']
    dataset['Currency'] = 'CNY'
    dataset['ExchangeRate'] = row['data']['exchange_rate'].to_f
    dataset['AmountDue'] = (dataset['Total'].to_f) * dataset['ExchangeRate']

    dataset
  end

  def build_info_row(key, value, start_date, end_date)
    dataset = {}

    dataset['DSP'] = value['dsp_name']
    dataset['DateStart'] = value['start_date'] && value['start_date'].to_datetime
    dataset['DateEnd'] = value['start_date'] && value['end_date'].to_datetime
    dataset['TypeOfSales'] = value['sales_type']
    dataset['SalesUnit'] =  value['sales_unit']
    dataset['Total'] = value['income'].to_f
    dataset['Currency'] = 'CNY'
    dataset['ExchangeRate'] = value['exchange_rate'] #(value['汇率'].to_f == 0)? 1 : value['汇率'].to_f
    dataset['AmountDue'] = dataset['Total'].to_f * dataset['ExchangeRate']

    dataset
  end

end
