class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :label_id,
             :label_name,
             :gender_type,
             :description,
             :operator,
             :approve_status,
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
