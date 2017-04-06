class Artist < ApplicationRecord
	enum status: [:disabled,:enabled]
	enum gender_type: [:male,:female,:team]
	enum approve_status: [:todo,:agree,:disagree]
	validates :name, presence: true
	belongs_to :country
	has_many :resources, as: :target, :dependent => :destroy
	accepts_nested_attributes_for :resources, :allow_destroy => true
	scope :recent, -> { order('id DESC') }
	default_scope -> { where(status: :enabled) }
end
