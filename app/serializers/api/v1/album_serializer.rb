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
    :audits,
    :multi_languages
    def multi_languages
      @multi_languages = object.multi_languages
      @multi_languages.map { |album| {
        name: album.name,
        id: album.id,
        language_id: album.language_id,
        language_name: album.language.name
      }}
    end
end
