class PermissionGroup < ApplicationRecord
  has_many :permissions
  scope :recent, -> {order("sort ASC")}
  #has_many :subclass
  has_many :subclass, class_name: 'PermissionGroup',foreign_key: :parent_id



  class_attribute :as_list_json_options
  self.as_list_json_options={
      only: [:id, :name],
      include: {
        subclass: {only: [:id,:name],
          methods: [:permissions]
          }
      }
  }

end
