class Track < ApplicationRecord
  audited
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :artists
  belongs_to :language
  has_many :accompany_artists, as: :target, :dependent => :destroy
  accepts_nested_attributes_for :accompany_artists, :allow_destroy => true
  has_many :track_resources
  accepts_nested_attributes_for :track_resources, :allow_destroy => true
  has_many :track_composers
  accepts_nested_attributes_for :track_composers, :allow_destroy => true

  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false

  validates :title, presence: true , uniqueness: true
  validates :isrc, presence: true, uniqueness: true

  scope :recent, -> { order('id DESC') }

end
