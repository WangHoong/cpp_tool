class Cp::Authorize < ApplicationRecord
  self.table_name=:cp_authorizes
  belongs_to :contract
  belongs_to :currency
  belongs_to :authorized_range
  has_many :authorized_businesses
  has_many :contract_resources, as: :target, :dependent => :destroy

  accepts_nested_attributes_for :contract_resources, :allow_destroy => true
  accepts_nested_attributes_for :authorized_businesses,  :allow_destroy => true

  def contract_resources=(attr)
    self.contract_resources_attributes = attr
  end

  def authorized_businesses=(attr)
    self.authorized_businesses_attributes=attr
  end

  #还剩多少天结束
  def end_day
     return nil if end_time.blank? or end_time < Time.now
     day = end_time.to_date - DateTime.now.to_date
     return day.to_i
  end

  class_attribute :as_list_json_options
  self.as_list_json_options={
      only: [:id,:number, :contract_id, :currency_id, :account_id, :start_time,:end_time,:tracks_count,:created_at, :updated_at]
  }

  class_attribute :as_show_json_options
  self.as_show_json_options={
      only: [:id,:number, :contract_id, :currency_id, :account_id, :start_time,:end_time,:tracks_count,:created_at, :updated_at],
      include: [:authorized_businesses,:contract_resources],
      methods: [:end_day]
  }


end
