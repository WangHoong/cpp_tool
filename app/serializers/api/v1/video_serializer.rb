class Api::V1::VideoSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :format,
    :label,
    :release_date,
    :status,
    :remark,
    :created_at,
    :updated_at,
    :multi_languages
  def multi_languages
    @multi_languages = object.multi_languages
    @multi_languages.map { |artist| {
      name: artist.name,
      language: artist.language.name
    }}
  end
end
