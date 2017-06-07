class Trade < ApplicationRecord
	enum status: [:default,:prepay,:consume,:refund]
	belongs_to :provider
 
end
