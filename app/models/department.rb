class Department < ApplicationRecord
	validates :name, presence: true

  scope :sp_sort, -> { where(optype: :sp) }
	scope :cp_sort, -> { where(optype: :cp) }
end
