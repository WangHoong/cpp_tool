class Api::V1::ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :label_id,
             :label_name,
             :gender_type,
             :description,
             :deleted,
             :website,
             :country,
             :created_at,
             :updated_at
end
