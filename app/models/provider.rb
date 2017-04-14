class Provider < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:todo,:agree,:disagree]
	validates :name, presence: true

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:property,:data_type,:contact,:tel,:address,:email,:bank_name,:account_no,:user_name,:cycle,:start_time]
	}



end
