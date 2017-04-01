class Artist < ApplicationRecord
	enum status: [:disabled,:enabled]
	enum gender_type: [:male,:female,:team]
	enum approve_status: [:todo,:agree,:disagree]
	validates :name, presence: true
	belongs_to :country
	scope :recent, -> { order('id DESC') }
	default_scope -> { where(status: :enabled) }
end
