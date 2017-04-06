class Permission < ApplicationRecord
	enum status: [:disabled,:enabled]
  has_and_belongs_to_many :roles
	has_and_belongs_to_many :users

  default_scope -> { where(status: :enabled) }
	#default_scope -> { order('sort ASC') }
  validates :name, presence: :name
  scope :recent, -> {order("sort ASC")}
end
