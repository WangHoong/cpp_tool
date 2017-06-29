class User < ApplicationRecord
  # bcrypt secure password
  has_secure_password

  has_and_belongs_to_many :roles
  has_many :revenues
  validates :name, presence: true
  validates :email, presence: true

  scope :recent, -> { order('id DESC') }


  def roles_permissions
    if is_admin
      permissions = Permission.all
    else
      permissions = roles.includes(:permissions).map{|role| role.permissions.select(:id,:module_name,:rule_type)}.flatten.uniq
    end
    @permissions = permissions.group_by(&:module_name).map{|key, value| [key, value.map(&:rule_type)]}
    return  @permissions.to_h
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
