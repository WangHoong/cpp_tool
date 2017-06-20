class Video < ApplicationRecord
  include ApproveWorkflow
  audited
  # 视频状态 0:待审核 1:已审核 2:已拒绝
  enum status: [:pending,:accepted,:rejected]

  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false

  scope :recent, -> { order('id DESC') }

  has_and_belongs_to_many :tracks

  has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name

  # primary artist video association
  has_many :primary_artist_types, -> { where artist_type: 'primary' },
            class_name: 'ArtistVideo', :foreign_key => :video_id,
            dependent: :destroy
  has_many :primary_artists, :through => :primary_artist_types, class_name: 'Artist', :source => :artist

  # featuring artist video association
  has_many :featuring_artist_types, -> { where artist_type: 'featuring' },
            class_name: 'ArtistVideo', :foreign_key => :video_id,
            dependent: :destroy
  has_many :featuring_artists, :through => :featuring_artist_types, class_name: 'Artist', :source => :artist

  # video resource association
  has_many :video_resources, -> { where resource_type: 'video' },
            class_name: 'VideoResource', dependent: :destroy
  has_many :videos, :through => :video_resources, class_name: 'Resource', :source => :resource

  # cover resource association
  has_many :cover_resources, -> { where resource_type: 'cover' },
            class_name: 'VideoResource', dependent: :destroy
  has_many :covers, :through => :cover_resources, class_name: 'Resource', :source => :resource

  has_many :multi_languages, as: :multilanguage

  accepts_nested_attributes_for :multi_languages, :allow_destroy => true
  accepts_nested_attributes_for :primary_artists, :allow_destroy => true
  accepts_nested_attributes_for :featuring_artists, :allow_destroy => true
  accepts_nested_attributes_for :videos, :allow_destroy => true
  accepts_nested_attributes_for :covers, :allow_destroy => true
	accepts_nested_attributes_for :tracks, :allow_destroy => true
  before_save :add_audit_comment

  private

  def add_audit_comment
    unless audited_changes.empty?
       self.audit_comment = '视频数据发生变更' if self.id
       self.audit_comment = '新建视频' if self.id.blank?
    end
  end
end
