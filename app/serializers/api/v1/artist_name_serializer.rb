class Api::V1::ArtistNameSerializer < ActiveModel::Serializer
  attributes :id, :name, :language
  belongs_to :Artist
end
