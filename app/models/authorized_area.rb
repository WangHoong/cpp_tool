class AuthorizedArea < ApplicationRecord
	validates :name, presence: true
end
