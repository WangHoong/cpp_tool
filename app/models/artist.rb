class Artist < ApplicationRecord
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum gender_type: [:male,:female,:team]
	validates :name, presence: true
	belongs_to :country
	has_many :artist_resources
	has_many :resources, through: :artist_resources, :dependent => :destroy
	accepts_nested_attributes_for :artist_resources, :allow_destroy => true
	scope :recent, -> { order('id DESC') }

	require 'workflow'
	require Rails.root.join('lib', 'approve_workflow.rb')
	include Workflow
	include ApproveWorkflow
end
