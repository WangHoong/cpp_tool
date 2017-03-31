class Artist < ApplicationRecord
	validates :name, presence: true
	scope :recent, -> { order('id DESC') }
end
