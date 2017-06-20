class Api::V1::AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre,
    :format,
    :label,
    :status,
    :release_version,
    :remark,
    :upc,
    :multi_languages
  def multi_languages
    @multi_languages = object.multi_languages
    @multi_languages.map { |artist| {
      name: artist.name,
      language: artist.language.name
    }}
  end
end
