class Api::V1::Videos::AlbumSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :album_names
  def album_names
    @album_names = object.album_names
    @album_names.map { |album| {
      name: album.name,
      language: album.language.name
    }}
  end
end
