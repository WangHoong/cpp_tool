class Track < ApplicationRecord
  include ApproveWorkflow
  audited
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :artists 
  belongs_to :language
  belongs_to :provider
  belongs_to :genre
  belongs_to :contract, class_name: 'Cp::Contract',foreign_key: :contract_id
  belongs_to :authorize, class_name: 'Cp::Authorize',foreign_key: :authorize_id
  has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name
  has_many :accompany_artists, as: :target, :dependent => :destroy
  accepts_nested_attributes_for :accompany_artists, :allow_destroy => true
  has_many :track_resources
  accepts_nested_attributes_for :track_resources, :allow_destroy => true
  has_many :track_composers
  accepts_nested_attributes_for :track_composers, :allow_destroy => true
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
  enum status: [:pending,:accepted,:rejected]

  validates :title, presence: true , uniqueness: true
  validates :isrc, presence: true, uniqueness: true

  before_save :add_audit_comment
  before_destroy :dec_tracks_count
  after_create :inc_tracks_count

  scope :recent, -> {order('id DESC')}
  scope :album_order, -> { order('position ASC') }

  def provider_name
    provider.try(:name)
  end

  def contract_name
    contract.try(:contract_no)
  end

  def genre_name
    genre.try(:name)
  end

  def primary_artists
    artists.map { |artist| { name: artist.name, id: artist.id } }
  end

  class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists],
      methods: [:provider_name,:contract_name]
	}

  class_attribute :as_album_list_json_options
	self.as_album_list_json_options={
			only: [:id, :title, :label, :is_agent, :updated_at, :copyright_attribution, :position],
      methods: [:provider_name, :primary_artists]
	}

  class_attribute :as_show_json_options
  self.as_show_json_options={
     only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:pline,:cline,
           :copyright,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists,:track_resources,:track_composers,audits: {only: [:id,:user_id,:username,:action,:version,:remote_address,:comment,:created_at]}],
      methods: [:provider_name,:contract_name,:genre_name]
  }

 #艺人的歌曲列表
  class_attribute :as_artlist_tracks_json_options
	self.as_artlist_tracks_json_options={
			only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists]
	}

  private

	def add_audit_comment
		unless audited_changes.empty?
			 self.audit_comment = '歌曲数据发生变更' if self.id
			 self.audit_comment = '新建歌曲' if self.id.blank?
		end
	end

  def inc_tracks_count
    self.artists.each do |artist|
      Artist.increment_counter('tracks_count', artist.id)
    end
  end

  def dec_tracks_count
    self.artists.each do |artist|
      Artist.decrement_counter('tracks_count', artist.id)
    end
  end


end
