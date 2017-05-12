class AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre,
    :format,
    :label,
    :release_version,
    :remark,
    :upc,
    :approve
  has_many :primary_artists
  has_many :featuring_artists
  has_many :songs
  has_many :images
  belongs_to :language
  class ArtistSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
  class LanguageSerializer < ActiveModel::Serializer
    attributes :name
  end

  def approve
    @createAudit = object.audits.select { |audit|  audit.action == 'create'}.first
    @updateAudit = object.audits.select { |audit|  audit.action == 'update' && !!audit.audited_changes['status']}
    .sort { |x,y| y.created_at <=> x.created_at }
    .first

    {
      approver_name: @updateAudit&&@updateAudit['username'] || '',
      approve_at: @updateAudit&&@updateAudit['created_at'] || '',
      status: object&&object['status'] || '',
      creator_name: @updateAudit&&@createAudit['username'] || '',
      created_at: object&&object['created_at'] || '',
      updated_at: object&&object['updated_at'] || '',
      not_through_reason: object&&object['not_through_reason'] || ''
    }
 end
end
