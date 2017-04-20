class ReportAnalyser

  STD_FIELDS_HASH = {
    date: "日期",
    provider: "代理商",
    dsp: "分发渠道",
    track_id: "歌曲id",
    isrc: "ISRC",
    upc: "UPC",
    track_name: "歌曲名",
    album_name: "专辑名",
    artist_name: "艺人",
    business: "业务模式",
    price: "单价",
    amount: "数量",
    country: "国家",
    report_currency: "报表货币",
    account_currency: "结算货币",
    ex_rate: "汇率"
  }

  def self.parse(report)
    ## url = report.files.last.url
    url = "https://topdmc-new.s3.cn-north-1.amazonaws.com.cn/reports/d49b0019d5f34df193dff85e21d7d2fa/origin.xlsx"
    xlsx = Roo::Spreadsheet.open(url)

    # Extend data from 'standard report'
    sheet = xlsx.sheet(0)
    sheet.each(STD_FIELDS_HASH.merge({clean: true})) do |row|
      puts row
      # Check Date

      # Match track info
      # Fetch by isrc/track_id/track_name+album_name+artist_name
      if row['track_id'].present?
        @track = Track.find row['track_id']
      elsif row['isrc'].present?
        @track = Track.find_by_isrc row['isrc']
      else
        # use track name
      end

      # Check authorization
      # report.dsp.sp_authorizes.map(&:tracks)

      # Write to elastic search
      # data, note, err_message, category, created_at

    end
  end

end