class Provider < ApplicationRecord
	include Workflow
	include ApproveWorkflow
	audited
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:pending,:accept,:reject]
	enum property: [:personal,:company]

  has_many :trades

	validates :name, presence: true


  state_machine :status, initial: :pending do
		event :accept! do
			transition :pending => :accept
		end

		event :reject! do
			transition :pending => :reject
		end
	end


	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:property,:data_type,:contact,:tel,:address,:email,:bank_name,:account_no,:user_name,:cycle,:start_time,:status]
	}



end
