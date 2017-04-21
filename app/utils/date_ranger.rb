#

class DateRanger

  def self.parse(date_str)
    if date_str.index '-'
      components = date_str.split('-')
      return month_range(components.first).begin...month_range(components.last).end

    elsif is_month?(date_str)
      month_range(date_str)
    end
  end

  private
  def self.month_range(month_str)
    first_day = "#{month_str}01".to_date

    first_day.beginning_of_month...first_day.end_of_month
  end

  def self.is_month?(str)
    true
  end

end
