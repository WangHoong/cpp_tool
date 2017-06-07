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

          if header != HEADER
            msg = '文件格式不正确'
            result = {data: nil, note: nil, err_message: msg,category: 0,created_at: Time.now}
            note = RevenueAnalysis.new(result)
            type = SETTINGS['analysis_error_type']
            repository = AnalysisRepository.new(type: type)
            repository.save(note)
          else
            (2..spreadsheet.last_row).each do |i|
               row = spreadsheet.row(i)
               track = Track.find_by(title: row[6])
               album = Album.find_by(name: row[7])
               artist = Artist.find_by(name: row[8])
               dsp = Dsp.find_by(name: row[2])
               date = Date.strptime(row[0], "%Y%m").to_date
               hs_note = {sheet_name: spreadsheet.sheets.first,line_num: i,revenue_file_id: revenue_file.id,revenue_id: id,
                 dsp_id: revenue.dsp_id,dsp_name: revenue.dsp.try(:name),start_date: revenue.start_time,end_date: revenue.end_time,income: revenue.income}
               if date < revenue.start_time  or  date > revenue.end_time
                 result = {data: nil,note: hs_note, err_message: '歌曲结算周期不在报表结算周期内',category: 3,created_at: Time.now}
               elsif track.blank?
                 result = {data: nil,note: hs_note, err_message: '歌曲无法匹配',category: 3,created_at: Time.now}
               elsif album.blank?
                 result =  {data: nil,note: hs_note, err_message: '专辑无法匹配',category: 3,created_at: Time.now}
               elsif  artist.blank?
                 result = {data: nil,note: hs_note, err_message: '艺人无法匹配',category: 3,created_at: Time.now}
               elsif dsp.blank?
                 result = {data: nil,note: hs_note, err_message: '渠道方无法匹配',category: 3,created_at: Time.now}
               else
                 data = {date: row[0],title: row[6],album: row[7],artist: row[8],dsp: row[2]}
                 result = {data: data,note: hs_note, err_message: '匹配成功',category: 1,created_at: Time.now}
               end
               type = data.present? ? SETTINGS['analysis_success_type'] : SETTINGS['analysis_error_type']
               note = RevenueAnalysis.new(result)
               repository = AnalysisRepository.new(type: type)
               repository.save(note)
            end
          end
       end
     end


    def self.seach_revenue(id)
      revenue =  Revenue.find(id)
      @client ||= Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'], log: true
      @result = @client.search({body: {query: {bool: {must: [{term: {"note.revenue_id": revenue.id}}, {term: {category: 3}}]}}},scroll: "1m", index: SETTINGS['donkey_index']})
      @result['hits']['hits'].each do |node|
        p node
      end
    end

  end
end
