class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :gender_type,
             :description,
             :operator,
             :approve_status,
             :not_through_reason,
             :country,
             :resources
end
