class Dsp < ApplicationRecord
	include ApproveWorkflow
	audited

  belongs_to :department
	has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name
  enum status: [:pending,:accepted,:rejected]
  before_save :add_audit_comment
  validates :name, presence: true

  def department_name
    department.try(:name)
  end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc],
      methods: [:department_name]
	}

	private

	def add_audit_comment
		unless audited_changes.empty?
			 self.audit_comment = '渠道方数据发生变更' if self.id
			 self.audit_comment = '新建渠道方' if self.id.blank?
		end
	end

end
