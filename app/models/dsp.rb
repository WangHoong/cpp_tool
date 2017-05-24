class Dsp < ApplicationRecord
	validates :name, presence: true
  belongs_to :department
  has_many :contracts
	has_many :sp_contracts, class_name: 'Sp::Contract'
	has_many :sp_authorizes, class_name: 'Sp::Authorize', through: :sp_contracts, source: :authorizes

  def department_name
    self.department.try(:name)
  end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc],
      methods: [:department_name]
	}
end
