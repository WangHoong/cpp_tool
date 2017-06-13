class Dsp < ApplicationRecord
	include ApproveWorkflow
	audited
	validates :name, presence: true
  belongs_to :department
  enum status: [:pending,:accepted,:rejected]


  def department_name
    self.department.try(:name)
  end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc],
      methods: [:department_name]
	}
end
