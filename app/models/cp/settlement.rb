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

  def provider_name
    provider.try(:name)
	end

	def dsp_name
		dsp.try(:name)
	end

  def self.as_list_json_options
     as_list_json = {
    			only: [:id, :settlement_amount,:settlement_cycle_start,:settlement_cycle_end,:settlement_date,:status,:created_at,:updated_at],
          methods: [:provider_name]
        }
  end

  def self.as_show_json_options
     as_list_json = {
			   only: [:id, :settlement_amount,:settlement_cycle_start,:settlement_cycle_end,:settlement_date,:status,:created_at,:updated_at],
			   methods: [:provider_name,:dsp_name]
        }
  end

end
