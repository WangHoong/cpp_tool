class Api::V1::Albums::ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :artist_names
  def artist_names
    @artist_names = object.artist_names
    @artist_names.map { |artist| {
      name: artist.name,
      language: artist.language.name
    }}
  end
end
