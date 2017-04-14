class User < ApplicationRecord
  # bcrypt secure password
  has_secure_password

  has_and_belongs_to_many :roles

  validates :name, presence: true
  validates :email, presence: true

  scope :recent, -> { order('id DESC') }



  class_attribute :as_list_json_options
  self.as_list_json_options={
      only: [:id, :name, :email, :phone, :avatar_url,:status, :created_at, :updated_at]
  }

end
