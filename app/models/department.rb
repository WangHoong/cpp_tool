class Department < ApplicationRecord
	validates :name, presence: true
 
  scope :sp_sort, -> { where(sort: :sp) }
end
