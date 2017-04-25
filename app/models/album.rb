class Album < ApplicationRecord
  validates :name, :language_id, :genre, :format, presence: true
  validates :label, presence: true
  validates_inclusion_of :genre, in: CONSTANTS['genres'].keys, allow_nil: true
  validates_inclusion_of :format, in: CONSTANTS['album_types'].keys, allow_nil: true

  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false

  enum status: [:todo, :agree, :disagree]

  scope :recent, -> { order('id DESC') }

  belongs_to :language

  # primary artist album association
  has_many :primary_artist_types, -> { where association_type: 'AlbumOfPrimaryArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :primary_artists, :through => :primary_artist_types, class_name: 'Artist', :source => :artist

  # featuring artist album association
  has_many :featuring_artist_types, -> { where association_type: 'AlbumOfFeaturingArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :featuring_artists, :through => :featuring_artist_types, class_name: 'Artist', :source => :artist

  # songs resource association
  has_many :song_resources, -> { where resource_type: 'song' },
            class_name: 'AlbumResource', dependent: :destroy
  has_many :songs, :through => :song_resources, class_name: 'Resource', :source => :resource

  # images resource association
  has_many :image_resources, -> { where resource_type: 'image' },
            class_name: 'AlbumResource', dependent: :destroy
  has_many :images, :through => :image_resources, class_name: 'Resource', :source => :resource


  accepts_nested_attributes_for :primary_artists, :allow_destroy => true
  accepts_nested_attributes_for :songs, :allow_destroy => true
  accepts_nested_attributes_for :images, :allow_destroy => true
end
