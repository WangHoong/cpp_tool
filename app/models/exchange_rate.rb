class ExchangeRate < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:enabled, :disabled]
	belongs_to :currency, class_name: "Currency", foreign_key: "currency_id"
	belongs_to :settlement_currency, class_name: 'Currency', foreign_key: "settlement_currency_id"
	scope :recent, -> { order('id DESC') }

  def currency_name
		currency.try(:name)
	end

	def settlement_currency_name
		settlement_currency.try(:name)
	end

	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :currency_id,:settlement_currency_id,:exchange_ratio,:status,:rate_time,:created_at,:updated_at],
      methods: [:currency_name,:settlement_currency_name]
	}
end
