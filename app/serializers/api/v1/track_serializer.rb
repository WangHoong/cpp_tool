class Api::V1::TrackSerializer < ActiveModel::Serializer
  attributes :id,
    :message,
    :status,
    :created_at,
    :updated_at
end
