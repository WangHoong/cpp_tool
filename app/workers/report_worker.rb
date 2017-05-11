class ReportWorker
  include Sidekiq::Worker
  sidekiq_options queue: :report, retry: true

  def perform(report_id)
    report = Report.find(report_id)
    response = report.analyses_data(:succeed)
    time = report.analyses_date(:succeed)

    bucket = {}
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

    bucket.each do |key, value|
      amount = 0
      info['provider_id'] = key
      info['currency_id'] = get_currency(key).try(:id)
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
      @settlement.save

    end
  end


  private
  def gen_settlement_workbook(bucket, start_date, end_date)
    res = {}
    bucket.each do |key, value|
      provider = get_provider(key)
      currency = provider.try(:currency)

      res[key] = Axlsx::Package.new do |p|
        sheet_name = "详情表"
        sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
        sheet.add_row ['ReportStart', 'ReportEnd', 'Year', 'Month', 'Day', 'PropertyID', 'DSP','ISRC', 'UPC', 'OwnerPropertyID', 'LabelName', 'Title', 'Artist', 'Album', 'TypeOfSales', 'SalesUnit', 'Total', 'Currency', 'ExchangeRate', 'AmountDue']

        value.each do |row|
          sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
          sheet.add_row build_detail_row(row, start_date, end_date).values
        end

        set = {}
        sheet_name = "数据汇总"
        sheet = find_or_create_sheet_by_name(p.workbook, sheet_name)
        sheet.add_row ['CP名称', provider.try(:name)]
        sheet.add_row ['结算货币', currency.try(:name)]
        sheet.add_row ['DSP', 'DateStart', 'DateEnd', 'TypeOfSales', 'SalesUnit', 'Total', 'Currency', 'ExchangeRate', 'AmountDue' ]

        value.each do |row|
          type = row['data']['业务模式']

          if set[type].blank?
            set[type] = (row['note'].slice('dsp_name', 'start_date', 'end_date', 'income').merge! row['data'].slice('业务模式', '数量', '结算货币', '汇率'))
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

  def get_currency(provider_id)
    provider = get_provider(provider_id)
    # TODO: Currency should not be nil
    currency = Currency.find(provider.try(:currency_id)) rescue Currency.first

    currency
  end

  def build_detail_row(row, start_date, end_date)
    dataset = {}

    date = row['note']['start_date'].try(:to_datetime)

    dataset['ReportStart'] = start_date
    dataset['ReportEnd'] = end_date
    dataset['Year'] = date && date.strftime('%Y')
    dataset['Month'] = date && date.strftime('%m')
    dataset['Day'] = date && date.strftime('%d')
    dataset['OwnerPropertyID'] = 'null'
    dataset['DSP'] = row['note']['dsp_name']
    dataset['ISRC'] = row['data']['ISRC']
    dataset['UPC'] = row['data']['UPC']
    dataset['PropertyID'] = row['note']['track_id']
    dataset['LabelName'] = row['note']['provider_name']
    dataset.merge! row['data'].slice('歌曲名', '艺人', '专辑名', '业务模式', '数量')
    dataset['Total'] = row['note']['income']
    dataset['Currency'] = 'CNY'
    dataset['ExchangeRate'] = 1
    dataset['AmountDue'] = (dataset['Total'].to_f) * dataset['ExchangeRate']

    dataset
  end

  def build_info_row(key, value, start_date, end_date)
    dataset = {}

    dataset['DSP'] = value['dsp_name']
    dataset['DateStart'] = value['start_date'] && value['start_date'].to_datetime
    dataset['DateEnd'] = value['start_date'] && value['end_date'].to_datetime
    dataset['TypeOfSales'] = key
    dataset['SalesUnit'] = value['数量'].to_f
    dataset['Total'] = value['income'].to_f
    dataset['Currency'] = value['结算货币']
    dataset['ExchangeRate'] = (value['汇率'].to_f == 0)? 1 : value['汇率'].to_f
    dataset['AmountDue'] = (dataset['Total'].to_f) * dataset['ExchangeRate']

    dataset
  end

end
