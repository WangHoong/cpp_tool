class PermissionGroup < ApplicationRecord
  has_many :permissions
  acts_as_nested_set

  scope :recent, -> {order("sort ASC")}
  scope :rootes, -> {where(parent_id: nil)}
  has_many :subclass, class_name: 'PermissionGroup',foreign_key: :parent_id


  class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name],
      include: [:permissions=>{only:[:id,:name,:display_name,:rule_type]}]
	}
end
