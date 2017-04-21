class ExchangeRate < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum status: [:enabled, :disabled]
	scope :recent, -> { order('id DESC') }
end
