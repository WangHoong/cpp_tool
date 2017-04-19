class ReportAnalyser

  # STD_FIELDS_HASH = {
  #   date: '日期',
  #   provider: '代理商',
  #   dsp: '分发渠道',
  #   track_id: '歌曲id',
  #   isrc: 'ISRC',
  #   upc: 'UPC',
  #   track_name: '歌曲名',
  #   album_name: '专辑名',
  #   artist_name: '艺人',
  #   business: '业务模式',
  #   price: '单价',
  #   amount: '数量',
  #   country: '国家',
  #   report_currency: '报表货币',
  #   account_currency: '结算货币',
  #   ex_rate: '汇率',
  # }

  def self.parse(report)
    ## url = report.files.last.url
    url = "https://topdmc-new.s3.cn-north-1.amazonaws.com.cn/reports/d49b0019d5f34df193dff85e21d7d2fa/origin.xlsx"
    xlsx = Roo::Spreadsheet.open(url)

    # Extend data from 'standard report'
    sheet = xlsx.sheet(0)
    sheet.each_row_streaming(offset: 1) do |row|
      puts row.inspect
    end
  end

end