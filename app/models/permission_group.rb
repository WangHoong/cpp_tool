class PermissionGroup < ApplicationRecord
  has_many :permissions
  scope :recent, -> {order("sort ASC")}
end
