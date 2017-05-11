class ExchangeRate < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:enabled, :disabled]
	belongs_to :currency, class_name: "Currency", foreign_key: "currency_id"
	belongs_to :settlement_currency, class_name: 'Currency', foreign_key: "settlement_currency_id"
	scope :recent, -> { order('id DESC') }
end
