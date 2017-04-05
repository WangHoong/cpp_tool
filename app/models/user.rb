class User < ApplicationRecord
  # bcrypt secure password
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true

  scope :recent, -> { order('id DESC') }
 



end
