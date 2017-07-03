include Workflow
class Cp::Settlement < ApplicationRecord
	self.table_name=:cp_settlements
	belongs_to :provider
	belongs_to :dsp
	belongs_to :currency
	enum status: [:pending, :confirmed, :paymented]
  scope :recent, -> { order('id DESC') }

	workflow_column :status
	workflow do
		state :pending do
			event :confirm, :transitions_to => :confirmed
		end

		state :confirmed do
			event :payment, :transitions_to => :paymented
		end

		state :paymented
	end

end
