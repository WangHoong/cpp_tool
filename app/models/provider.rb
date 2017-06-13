class Provider < ApplicationRecord
	include ApproveWorkflow
	audited
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:pending,:accepted,:rejected]
	enum property: [:personal,:company]

  has_many :trades

	validates :name, presence: true



	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:property,:data_type,:contact,:tel,:address,:email,:bank_name,:account_no,:user_name,:cycle,:start_time,:status],
			include: [audits: {only: [:id,:user_id,:username,:action,:version,:remote_address,:comment,:created_at]}]
	}



end
