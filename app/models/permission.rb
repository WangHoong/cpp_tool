class Permission < ApplicationRecord
	enum status: [:disabled,:enabled]
  belongs_to :permission_group
  has_and_belongs_to_many :roles
	has_and_belongs_to_many :users

  default_scope -> { where(status: :enabled) }
	default_scope -> { order('id ASC') }
  validates :name, presence: :name

  def is_selectd(ids)
    return true if ids.include?(self.id)
		return false
	end


	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name]
	}
end
