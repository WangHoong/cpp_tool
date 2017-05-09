class User < ApplicationRecord
  # bcrypt secure password
  has_secure_password

  has_and_belongs_to_many :roles

  validates :name, presence: true
  validates :email, presence: true

  scope :recent, -> { order('id DESC') }


  def roles_permissions
    permissions = roles.includes(:permissions).map {|role| role.permissions}.flatten.uniq
    group_ids =  permissions.map(&:permission_group_id).flatten.uniq
    groups = PermissionGroup.where(id: group_ids).map{|m| m.ancestors.map(&:id)}.flatten.uniq
    @groups = PermissionGroup.roots.recent.where(id: groups)
    groups = []
    @groups.each do |group|
        groups << {id: group.id,name: group.name,subclass: group.descendants}
    end
    return groups
  end




  class_attribute :as_list_json_options
  self.as_list_json_options={
      only: [:id, :name, :email, :phone, :avatar_url,:status, :created_at, :updated_at]
  }

  class_attribute :as_show_json_options
  self.as_show_json_options={
      only: [:id, :name, :email, :phone, :avatar_url,:status, :created_at, :updated_at],
      methods: [:roles_permissions]
  }


end
