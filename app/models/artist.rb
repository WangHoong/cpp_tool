class Artist < ApplicationRecord
	include Workflow
	include ApproveWorkflow
	audited
	acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
	enum gender_type: [:male,:female,:team]
	validates :name, presence: true
	belongs_to :country
	has_many :artist_names
	# songs resource association
	has_many :song_resources, -> { where resource_type: 'song' },
						class_name: 'ArtistResource', dependent: :destroy
	has_many :songs, :through => :song_resources, class_name: 'Resource', :source => :resource

  # images resource association
  has_many :image_resources, -> {where resource_type: 'image'},
           class_name: 'ArtistResource', dependent: :destroy
  has_many :images, :through => :image_resources, class_name: 'Resource', :source => :resource

	has_and_belongs_to_many :tracks 

  # artist album association
  has_many :artist_albums, class_name: 'ArtistAlbum'
  has_many :albums, :through => :artist_albums, class_name: 'Album', :source => :album

	accepts_nested_attributes_for :songs, :allow_destroy => true
	accepts_nested_attributes_for :images, :allow_destroy => true
	accepts_nested_attributes_for :artist_names, :allow_destroy => true

  scope :recent, -> {order('id DESC')}


	class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :name,:label_id,:label_name,:gender_type,:description,:status,:country_name,:country_id,:not_through_reason,:website],
			include: [:albums,:tracks]
	}

end
