class Api::V1::Videos::TrackSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :label,
             :copyright,
             :multi_languages
  def multi_languages
    @multi_languages = object.multi_languages
    @multi_languages.map { |album| {
      name: album.name,
      language: album.language.name
    }}
  end
  # has_many :primary_artists, serializer: Api::V1::Albums::ArtistSerializer
  # has_many :featuring_artists, serializer: Api::V1::Albums::ArtistSerializer
end
