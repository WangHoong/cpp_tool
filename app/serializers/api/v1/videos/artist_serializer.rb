class Api::V1::Videos::ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :multi_languages
  def multi_languages
    @multi_languages = object.multi_languages
    @multi_languages.map { |artist| {
      name: artist.name,
      language: artist.language.name
    }}
  end
end
