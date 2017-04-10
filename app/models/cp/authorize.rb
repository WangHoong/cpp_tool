class Cp::Authorize < ApplicationRecord
  self.table_name=:cp_authorizes
  belongs_to :contract
  belongs_to :currency

  has_many :authorized_businesses, as: :target, :dependent => :destroy
  has_many :assets, as: :target, :dependent => :destroy
  accepts_nested_attributes_for :authorized_businesses,  :allow_destroy => true
  accepts_nested_attributes_for :assets,:allow_destroy => true
  default_scope -> { includes(:assets,:authorized_businesses,:currency,:account) }
  scope :recent, -> { order('authorizes.id DESC') }


  #业务
  def businesses
     authorized_businesses.includes(:business).map{|m| Hash[{id: m.id,name: m.business.try(:name),is_whole: m.is_whole,
       divided_point: m.divided_point,areas_count: m.areas_count}]}
  end

  #状态
  def status
    if end_time.blank? or end_time < Time.now
        return 0  #失效
    elsif end_time <= Time.now.months_since(3)
        return 1 #快到期
    elsif end_time >= Time.now
        return 2 #未到期
    end
  end


  #还剩多少天结束
  def end_day
     return nil if end_time.blank? or end_time < Time.now
     day = end_time.to_date - DateTime.now.to_date
     return day.to_i
  end

end
