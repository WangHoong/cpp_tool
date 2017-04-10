class Asset < ApplicationRecord
	validates :url, presence: true
	belongs_to :target, polymorphic: true
end
