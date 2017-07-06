class Transation < ApplicationRecord
	enum status: [:pending,:paymented]
	belongs_to :provider
	belongs_to :target, polymorphic: true
	scope :recent, -> { order('id DESC') }

	def provider_name
		provider.try(:name)
	end

	def final_amount
		return  0 if balance.to_f > amount.to_f
		return  (balance - amount) * -1 if balance.to_f < amount.to_f
	end

	def self.as_list_json_options
		 as_list_json = {
					only: [:id,:provider_id,:amount,:balance,:subject,:status,:pay_time,:created_at,:updated_at],
					methods: [:provider_name,:final_amount]
				}
	end
end
