class Album < ApplicationRecord
  validates :name, :primary_artist_ids, :language_id, :genre, :format, presence: true
  validates :label, presence: true
  validates_inclusion_of :genre, in: CONSTANTS['genres'].keys, allow_nil: true
  validates_inclusion_of :format, in: CONSTANTS['album_types'].keys, allow_nil: true
  acts_as_paranoid
  scope :recent, -> { order('id DESC') }

  belongs_to :language

  has_many :resources, as: :target, :dependent => :destroy

  has_many :primary_artist_types, -> { where association_type: 'AlbumOfPrimaryArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :primary_artists, :through => :primary_artist_types, class_name: 'Artist', :source => :artist

  has_many :featuring_artist_types, -> { where association_type: 'AlbumOfFeaturingArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :featuring_artists, :through => :featuring_artist_types, class_name: 'Artist', :source => :artist

  accepts_nested_attributes_for :primary_artists, :allow_destroy => true
  accepts_nested_attributes_for :resources, :allow_destroy => true
end
