class Dsp < ApplicationRecord
	validates :name, presence: true
  belongs_to :department
  has_many :contracts
	has_many :sp_contracts, class_name: 'Sp::Contract'
	has_many :sp_authorizes, class_name: 'Sp::Authorize', through: :sp_contracts, source: :authorizes
 

end
