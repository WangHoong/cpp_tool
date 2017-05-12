class Cp::Settlement < ApplicationRecord
	self.table_name=:cp_settlements
	belongs_to :provider
	belongs_to :dsp
	belongs_to :currency
  scope :recent, -> { order('id DESC') }
end
