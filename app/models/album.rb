class Album < ApplicationRecord
  include Workflow
	include ApproveWorkflow
  audited
  validates :name, :language_id, :genre, :format, presence: true
  validates :label, presence: true
  validates_inclusion_of :genre, in: CONSTANTS['genres'].keys, allow_nil: true
  validates_inclusion_of :format, in: CONSTANTS['album_types'].keys, allow_nil: true

  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false

  scope :recent, -> { order('id DESC') }

  belongs_to :language
  has_and_belongs_to_many :tracks

  # primary artist album association
  has_many :primary_artist_types, -> { where album_type: 'AlbumOfPrimaryArtist' },
            class_name: 'ArtistAlbum', :foreign_key => :album_id,
            dependent: :destroy
  has_many :primary_artists, :through => :primary_artist_types, class_name: 'Artist', :source => :artist

  # featuring artist album association
  has_many :featuring_artist_types, -> { where album_type: 'AlbumOfFeaturingArtist' },
            class_name: 'ArtistAlbum', :foreign_key => :album_id,
            dependent: :destroy
  has_many :featuring_artists, :through => :featuring_artist_types, class_name: 'Artist', :source => :artist

  # songs resource association
  has_many :material_resources, -> { where resource_type: 'material' },
            class_name: 'AlbumResource', dependent: :destroy
  has_many :materials, :through => :material_resources, class_name: 'Resource', :source => :resource

  # images resource association
  has_many :cover_resources, -> { where resource_type: 'cover' },
            class_name: 'AlbumResource', dependent: :destroy
  has_many :covers, :through => :cover_resources, class_name: 'Resource', :source => :resource


  accepts_nested_attributes_for :primary_artists, :allow_destroy => true
  accepts_nested_attributes_for :materials, :allow_destroy => true
  accepts_nested_attributes_for :covers, :allow_destroy => true
end
