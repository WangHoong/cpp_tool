class Dsp < ApplicationRecord
	include Workflow
	include ApproveWorkflow
	audited
	validates :name, presence: true
  belongs_to :department
  enum status: [:pending,:accepted,:rejected]
	def create_auditables(user,action,comment)
		write_audit(action: action,user_id: user.id,username: user.name, user_type: 'User', comment: comment)
	end

  def department_name
    self.department.try(:name)
  end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc],
      methods: [:department_name]
	}
end
