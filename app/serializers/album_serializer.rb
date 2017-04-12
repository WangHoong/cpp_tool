class AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre

  has_many :primary_artists
  has_many :featuring_artists
  class ArtistSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
