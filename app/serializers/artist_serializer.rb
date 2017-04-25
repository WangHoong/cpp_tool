class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :gender_type,
             :description,
             :operator,
             :approve_status,
             :not_through_reason,
             :deleted,
             :country,
             :resources,
             :approve

  def resources
    object.artist_resources.map do |resource|
      Hash[{
        id: resource.id,
        field: resource.field,
        resource: resource.resource
      }]
    end
  end
end
