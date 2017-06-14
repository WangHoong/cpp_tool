class Provider < ApplicationRecord
	include ApproveWorkflow
	audited
	has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:pending,:accepted,:rejected]
	enum property: [:personal,:company]

  has_many :trades
  before_save :add_audit_comment
	validates :name, presence: true



	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:property,:data_type,:contact,:tel,:address,:email,:bank_name,:account_no,:user_name,:cycle,:start_time,:status],
			include: [audits: {only: [:id,:user_id,:username,:action,:version,:remote_address,:comment,:created_at]}]
	}

	private

	def add_audit_comment
		unless audited_changes.empty?
			 self.audit_comment = '版权方数据发生变更' if self.id
			 self.audit_comment = '新建版权方' if self.id.blank?
		end
	end

end
