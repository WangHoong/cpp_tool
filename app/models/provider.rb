class Provider < ApplicationRecord
	include ApproveWorkflow
	audited
	has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name
  has_many :copyrights
	accepts_nested_attributes_for :copyrights, :allow_destroy => true
	has_many :transations

	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:pending,:accepted,:rejected]
	enum property: [:personal,:company]


  before_save :add_audit_comment
	validates :name, presence: true

  def copyright_name
		final_provider.name
	end

 def prepay_amount_total
	 transations.where(target_type: 'Cp::Contract').sum(:amount).to_f
 end

 def settlement_amount_total
	 transations.where(target_type: 'Cp::Settlement').sum(:amount).to_f
 end

 def final_amount_total
	  settlement_amount_total > 0 ? current_amount - settlement_amount_total : 0
 end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:property,:data_type,:contact,:tel,:address,:email,:bank_name,:account_no,:user_name,:cycle,:start_time,:status],
			include: [:copyrights,audits: {only: [:id,:user_id,:username,:action,:version,:remote_address,:comment,:created_at]}]
	}


	class_attribute :as_trades_list_json_options
	self.as_trades_list_json_options={
			only: [:id, :name,:current_amount],
			methods: [:prepay_amount_total,:settlement_amount_total,:final_amount_total]
	}


	private

	def add_audit_comment
		unless audited_changes.empty?
			 self.audit_comment = '版权方数据发生变更' if self.id
			 self.audit_comment = '新建版权方' if self.id.blank?
		end
	end

end
