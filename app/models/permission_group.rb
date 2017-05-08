class PermissionGroup < ApplicationRecord
  has_many :permissions
  acts_as_nested_set

  scope :recent, -> {order("sort ASC")}
  has_many :subclass, class_name: 'PermissionGroup',foreign_key: :parent_id



end
