class Artist < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'string', :deleted_value => 1
	enum gender_type: [:male,:female,:team]
	enum approve_status: [:todo,:agree,:disagree]
	validates :name, presence: true
	belongs_to :country
	has_many :resources, as: :target, :dependent => :destroy
	accepts_nested_attributes_for :resources, :allow_destroy => true
	scope :recent, -> { order('id DESC') }
	#default_scope -> { where(deleted: false) }
end
