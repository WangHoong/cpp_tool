class Album < ApplicationRecord
	include ApproveWorkflow
  audited
	enum status: [:pending,:accepted,:rejected]
  validates :name, :language_id, :genre_id, :format, presence: true
  validates :label, :original_label_number, presence: true
  #validates_inclusion_of :genre, in: CONSTANTS['genres'].keys, allow_nil: true
  validates_inclusion_of :format, in: CONSTANTS['album_types'].keys, allow_nil: true

  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false

  scope :recent, -> { order('id DESC') }
  belongs_to :genre
	belongs_to :sub_genre, class_name: 'Genre'
  belongs_to :language
  has_many :multi_languages, as: :multilanguage
  has_and_belongs_to_many :tracks
	has_and_belongs_to_many :videos

  has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name
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
	accepts_nested_attributes_for :featuring_artists, :allow_destroy => true
  accepts_nested_attributes_for :materials, :allow_destroy => true
  accepts_nested_attributes_for :covers, :allow_destroy => true
  accepts_nested_attributes_for :multi_languages, :allow_destroy => true
	accepts_nested_attributes_for :tracks, :allow_destroy => true
	accepts_nested_attributes_for :videos, :allow_destroy => true
  before_save :add_audit_comment
	before_destroy :dec_albums_count
  after_create :inc_albums_count
  after_save :execute_sql_dat

  private

  def add_audit_comment
    unless audited_changes.empty?
       self.audit_comment = '专辑数据发生变更' if self.id
       self.audit_comment = '新建专辑' if self.id.blank?
    end
  end

	def inc_albums_count
		self.primary_artists.each do |artist|
			Artist.increment_counter('albums_count', artist.id)
		end
	end

	def dec_albums_count
		self.primary_artists.each do |album|
			Artist.decrement_counter('albums_count', artist.id)
		end
	end

	def execute_sql_dat
		sql_artist = "update artists set tracks_count =(select count(*) from artist_tracks join tracks on artist_tracks.track_id = tracks.id and tracks.deleted=0  where artist_tracks.artist_id=artists.id),
		albums_count =(select count(*) from artist_albums join albums on artist_albums.`album_id`=albums.id and albums.deleted=0  where artist_albums.artist_id=artists.id) "
		ActiveRecord::Base.connection.execute(sql_artist)

		sql_blubms = "update albums set tracks_count =(select count(*) from albums_tracks join tracks on albums_tracks.`track_id`=tracks.id and tracks.deleted=0  where albums_tracks.album_id=albums.id)"
		ActiveRecord::Base.connection.execute(sql_blubms)
	end

end
