class DistributionService

  READABLE_ITEMS = {
    track: '歌曲名',
    album: '专辑名称',
    artists: '演唱者',
    lyric: '曲作者',
    composer: '词作者',
    genre: '风格类型',
    cp: '实有主体',
    authorize_period: '授权期限',
    language: '语言',
    business: '授权业务',
    location: '授权区域'
  }

  def self.make_workbook(distribution)
    Axlsx::Package.new do |p|
      sheet = self.find_or_create_sheet_by_name(p.workbook, distribution.id.to_s)
      header = distribution.items.map { |item| READABLE_ITEMS[item.to_sym] }
      header += [READABLE_ITEMS[:business], READABLE_ITEMS[:location]]
      sheet.add_row header

      distribution.records.each do |record|
        content = []
        distribution.items.each do |item|
          content << get_item(record, item)
        end

        record['businesses'].each do |b|
          row = content + [b['business'], b['areas'].join('/')]
          sheet.add_row row if row.present?
        end

        if record['businesses'].blank?
          sheet.add_row content if content.present?
        end
      end
    end
  end

  def self.find_or_create_sheet_by_name(workbook, name)
    sheet = workbook.sheet_by_name(name)
    sheet = workbook.add_worksheet(name: name) if sheet.blank?

    sheet
  end


  def self.get_item(record, item)
    case item.to_sym
    when :track
      return record['track']['title'].gsub('￾', '')
    when :album
      return record['track']['album_name']
    when :artists
      return record['track']['artists_name'] && record['track']['artists_name'].join(',')
    when :lyric
      return record['lyric']
    when :composer
      return record['melody']
    when :genre
      return record['genre']
    when :cp
      return record['publisher']['name']
    when :authorize_period
      start_date = record['authorize']['start_time'].to_date.to_s rescue nil
      end_date = record['authorize']['end_time'].to_date.to_s rescue nil
      return "#{start_date} -- #{end_date}"
    when :language
      return record['track']['language']
    end
  end
end
