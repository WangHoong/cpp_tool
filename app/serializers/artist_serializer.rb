class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :gender_type,
             :description,
             :operator,
             :approve_status,
             :country,
             :resources
end
