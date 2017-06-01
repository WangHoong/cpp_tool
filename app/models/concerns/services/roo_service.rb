require 'roo'
module Services
  class RooService
     HEADER = ["日期", "代理商", "分发渠道", "歌曲id", "ISRC", "UPC ", "歌曲名", "专辑名", "艺人", "业务模式", "单价", "数量", "国家", "报表货币", "结算货币", "汇率"]
     def self.validate_revenue(id)
       revenue = Revenue.find(id)
       revenue_file = RevenueFile.find_by(revenue_id: id)
       url = revenue_file.try(:url)
       if url.present?
         spreadsheet = Roo::Spreadsheet.open(url)
         header = spreadsheet.row(1)
         repository = AnalysisRepository.new
          if header != HEADER
            msg = '文件格式不正确'
            result = {data: nil, note: nil, err_message: msg,category: 0,created_at: Time.now}
            note = RevenueAnalysis.new(result)
            repository.save(note)
          else
            data = []
            (2..spreadsheet.last_row).each do |i|
               row = spreadsheet.row(i)
               track = Track.find_by(title: row[6])
               if track.blank?
                 note = {sheet_name: spreadsheet.sheets.first,line_num: i,revenue_file_id: revenue_file.id,revenue_id: id,
                   dsp_id: revenue.dsp_id,dsp_name: revenue.dsp.try(:name),start_date: revenue.start_time,end_date: revenue.end_time,income: revenue.income}
                 data = {date: row[0],title: row[6],album: row[7],artist: row[8],dsp: row[2]}
                 result = {data: data,note: note, err_message: '歌曲不存在',category: 3,created_at: Time.now}
                 note = RevenueAnalysis.new(result)
                 repository.save(note)
               end
            end
          end
       end
     end

    def self.seach_revenue(id)
      revenue =  Revenue.find(id)
      @client ||= Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'], log: true
      @result = @client.search({body: {query: {bool: {must: [{term: {"note.revenue_id": revenue.id}}, {term: {category: 3}}]}}},scroll: "1m", index: "donkey_test"})
      @result['hits']['hits'].each do |node|
        p node
      end
    end

  end
end
