class Cp::Authorize < ApplicationRecord
  self.table_name=:cp_authorizes
  belongs_to :contract
  belongs_to :currency
  belongs_to :authorized_range
  has_many :authorized_businesses
  has_many :contract_resources, as: :target, :dependent => :destroy
  has_many :resources, through: :contract_resources, :dependent => :destroy
  accepts_nested_attributes_for :contract_resources, :allow_destroy => true
  accepts_nested_attributes_for :authorized_businesses,  :allow_destroy => true


  scope :recent, -> { order('authorizes.id DESC') }


 


  #还剩多少天结束
  def end_day
     return nil if end_time.blank? or end_time < Time.now
     day = end_time.to_date - DateTime.now.to_date
     return day.to_i
  end

end
