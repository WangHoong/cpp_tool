class Artist < ApplicationRecord
	require 'workflow'
	require Rails.root.join('lib', 'approve_workflow.rb')
	include Workflow
	include ApproveWorkflow
	
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum gender_type: [:male,:female,:team]
	enum approve_status: [:pending,:accepted,:rejected]
	validates :name, presence: true
	belongs_to :country
	has_many :artist_resources
	has_many :resources, through: :artist_resources, :dependent => :destroy
	accepts_nested_attributes_for :artist_resources, :allow_destroy => true
	scope :recent, -> { order('id DESC') }

	before_save :update_approve_status_modified

	private

	def update_approve_status_modified
		self.not_through_reason = nil if approve_status == 'accepted'
	end
end
