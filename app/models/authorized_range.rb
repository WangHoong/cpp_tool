class AuthorizedRange < ApplicationRecord
	has_many :authorized_businesses, as: :business, :dependent => :destroy
	validates :name, presence: true
end
