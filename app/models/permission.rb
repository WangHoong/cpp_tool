class Permission < ApplicationRecord
	enum status: [:disabled,:enabled]
  has_and_belongs_to_many :roles
	has_and_belongs_to_many :users
  belongs_to :permission_group

  default_scope -> { where(status: :enabled) }
	default_scope -> { order('sort ASC') }
  validates :name, presence: :name

end
