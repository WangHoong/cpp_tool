class Track < ApplicationRecord
  audited only: [:status]
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
  enum status: [:pending,:accept,:reject]

  #validates :title, presence: true , uniqueness: true
  validates :isrc, presence: true, uniqueness: true

  scope :recent, -> {order('id DESC')}

  def provider_name
    provider.try(:name)
  end

  def contract_name
    contract.try(:contract_no)
  end

  def genre_name
    genre.try(:name)
  end

  def approve
    @create_audit =  audits.where(action: 'create').first
    @update_audits = audits.where(action: 'update')
    {
      create_user: @create_audit.user.try(:name),
      update_audits: @update_audits.as_json(only: [:user_id,:username,:action,:audited_changes,:created_at])
    }
 end


  class_attribute :as_list_json_options
	self.as_list_json_options={
			only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists],
      methods: [:provider_name,:contract_name]
	}

  class_attribute :as_show_json_options
  self.as_show_json_options={
     only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists,:track_resources,:track_composers],
      methods: [:provider_name,:contract_name,:genre_name]
  }

  class_attribute :as_artlist_tracks_json_options
	self.as_artlist_tracks_json_options={
			only: [:id, :title,:isrc,:status,:language_id,:genre_id,:ost,:lyric,:label,:is_agent,:provider_id,:contract_id,:authorize_id,:remark,:created_at],
      include: [:albums,:artists]
	}



end
