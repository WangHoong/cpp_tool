class Album < ApplicationRecord
  acts_as_paranoid
  # validates :name, presence: true
  scope :recent, -> { order('id DESC') }

  has_many :primary_artist_types, -> { where association_type: 'AlbumOfPrimaryArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :primary_artists, :through => :primary_artist_types, class_name: 'Artist', :source => :artist

  has_many :featuring_artist_types, -> { where association_type: 'AlbumOfFeaturingArtist' },
            class_name: 'ArtistAssociation', :foreign_key => :association_id,
            dependent: :destroy
  has_many :featuring_artists, :through => :featuring_artist_types, class_name: 'Artist', :source => :artist

  accepts_nested_attributes_for :primary_artists, :allow_destroy => true
end
