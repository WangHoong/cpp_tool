class Role < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions




  class_attribute :as_json_options
  self.as_json_options={
      only: [:id, :name,:status],
      include: {permissions: {only: [:id,:name,:display_name,:rule_type]}}

  }
end
