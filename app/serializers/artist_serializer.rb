class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :label_id,
             :label_name,
             :gender_type,
             :description,
             :deleted,
             :website,
             :country,
             :songs,
             :albums,
             :images,
             :approve,
             :created_at,
             :updated_at
  has_many :artist_names
  class ArtistNameSerializer < ActiveModel::Serializer
    attributes :name, :language_name
    def language_name
      object.language.name
    end
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
      creator_name: @createAudit&&@createAudit['username'] || '',
      created_at: object&&object['created_at'] || '',
      updated_at: object&&object['updated_at'] || '',
      not_through_reason: object&&object['not_through_reason'] || ''
    }
 end
end
