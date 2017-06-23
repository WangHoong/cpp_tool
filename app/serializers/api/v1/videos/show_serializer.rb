class Api::V1::Videos::ShowSerializer < Api::V1::VideoSerializer
  # attributes :tracks_length
  # def tracks_length
  #   object.tracks.size
  # end
  has_many :primary_artists, serializer: Api::V1::Videos::ArtistSerializer
  has_many :featuring_artists, serializer: Api::V1::Videos::ArtistSerializer
  # has_many :albums, serializer: Api::V1::Videos::AlbumSerializer
end
