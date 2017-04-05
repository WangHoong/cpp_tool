class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :country,
             :gender_type,
             :description,
             :operator,
             :approve_status
end
