class Artist < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum gender_type: [:male,:female,:team]
	enum approve_status: [:todo,:agree,:disagree]
	validates :name, presence: true
	belongs_to :country
	has_many :resources, as: :target, :dependent => :destroy
	accepts_nested_attributes_for :resources, :allow_destroy => true
	scope :recent, -> { order('id DESC') }

	before_save :update_approve_status_modified

	private

	def update_approve_status_modified
		self.not_through_reason = nil if approve_status == 'agree'
	end
end
