module Services
  class RevenueService

    def self.make_workbook(revenue, type)
      analyses = revenue.analyses_data(type)
      Axlsx::Package.new do |p|
        header = revenue.analyses_header
        sheet = self.find_or_create_sheet_by_name(p.workbook, header['note']['sheet_name'])
        sheet.add_row header["data"]

        analyses.each do |row|
          next if row['data'].nil?
          sheet = self.find_or_create_sheet_by_name(p.workbook, row['note']['sheet_name'])
          sheet.add_row row['data'].values
        end
      end
    end

    def self.gen_settlement_workbook(provider_id, start_date = nil, end_date = nil)
      Axlsx::Package.new do |p|
        sheet_name = '1'
        data = self.extract_cp_data(provider_id, start_date, end_date)
        sheet = self.find_or_create_sheet_by_name(p.workbook, sheet_name)
        sheet.add_row ['SP', 'StartDate', 'EndData', 'Area', 'Income']

        data.each do |row|
          sheet = self.find_or_create_sheet_by_name(p.workbook, sheet_name)
          sheet.add_row row['note'].slice('dsp_id', 'start_date', 'end_date', 'area', 'income').values
        end
      end
    end

    # CAUTION! This method may be very slow
    def self.extract_cp_data(provider_id, start_date = nil, end_date = nil)
      provider = Provider.find provider_id rescue nil

      return [] if provider.nil?

      response = EsClient.instance.search(
        body: {
          query: cp_query(provider, start_date, end_date)
        },
        search_type: 'scan',
        scroll: '1m'
      )

      res = []
      begin
        response = EsClient.instance.scroll(scroll_id: response['_scroll_id'], scroll: '1m')
        res += response['hits']['hits'].map { |r| r['_source'] }
      end while response['hits']['hits'].present?

      res
    end

    def self.get_settlement_info(provider_id, start_date = nil, end_date = nil)
      provider = Provider.find provider_id rescue nil
      return [] if provider.nil?

      response = EsClient.instance.search(
        body: {
          query: cp_query(provider, start_date, end_date),
          aggs: {
            total_price: {
              sum: {
                field: "note.income"
              }
            },
            min_date: {
              min: {
                field: "note.start_date"
              }
            },
            max_date: {
              max: {
                field: "note.end_date"
              }
            }
          },
          size: 0
        }
      )

      total_income = response['aggregations']['total_price']['value'].round(2)
      start_date = response['aggregations']['min_date']['value_as_string']
      end_date = response['aggregations']['max_date']['value_as_string']

      return total_income, start_date, end_date
    end


    private
    def self.find_or_create_sheet_by_name(workbook, name)
      sheet = workbook.sheet_by_name(name)
      sheet = workbook.add_worksheet(name: name) if sheet.blank?

      sheet
    end


    def self.cp_query(provider, start_date = nil, end_date = nil)

      excluded_ids = Revenue.where(status: [:processing, :processed]).map(&:id)

      conditions = [
        { term: {'note.provider_id': provider.id} }
      ]

      if start_date.present? && end_date.present?
        conditions << {range: { 'note.start_date': { lte: start_date }}}
        conditions << {range: { 'note.end_date': { gte: end_date }}}
      else
        conditions << {range: {
          'created_at': { gte: provider && provider.last_settlement_time || '1979-01-01'.to_datetime }
        }}
      end

      {
        bool: {
          must: conditions,
          mustNot: [
            { terms: { 'note.revenue_id': excluded_ids } }
          ]
        }
      }
    end
  end
end
