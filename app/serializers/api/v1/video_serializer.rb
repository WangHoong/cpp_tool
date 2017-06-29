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
    :audits,
    :multi_languages
  def multi_languages
    @multi_languages = object.multi_languages
    @multi_languages.map { |artist| {
      name: artist.name,
      id: artist.id,
      language_id: artist.language_id,
      language_name: artist.language.name
    }}
  end
end
