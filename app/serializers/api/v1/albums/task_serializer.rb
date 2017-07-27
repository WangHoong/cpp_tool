class Api::V1::Albums::TaskSerializer < Api::V1::AlbumSerializer
  attributes :release_date,
    :language,
    :has_explict,
    :p_line_copyright,
    :c_line_copyright,
    :remark,
    :original_release_date,
    :original_label_number,
    :cd_volume,
    :updated_at,
    :primary_artists,
    :featuring_artists,
    :tracks,
    :multi_languages
  def multi_languages
    object.multi_languages.map { |m| {
      name: m.name,
      language: m.language
    }}
  end
  def primary_artists
    object.primary_artists.map { |a| {
      id: a.id,
      name: a.name,
      country: a.country,
      gender_type: a.gender_type,
      label: a.label_name,
      multi_languages: a.multi_languages.map { |m| {
        name: m.name,
        language: m.language
      }}
    }}
  end
  def featuring_artists
    object.featuring_artists.map { |a| {
      id: a.id,
      name: a.name,
      country: a.country,
      gender_type: a.gender_type,
      label: a.label_name,
      multi_languages: a.multi_languages.map { |m| {
        name: m.name,
        language: m.language
      }}
    }}
  end
  def tracks
    object.tracks.map { |a| {
      id: a.id,
      title: a.title,
      isrc: a.isrc,
      language: a.language,
      genre: a.genre,
      pline: a.pline,
      track_resources: a.track_resources,
      multi_languages: a.multi_languages.map { |m| {
        name: m.name,
        language: m.language
      }}
    }}
  end
  # has_many :primary_artists, include: :all, serializer: Api::V1::Albums::ArtistSerializer
  # has_many :featuring_artists, serializer: Api::V1::Albums::ArtistSerializer
  # has_many :tracks, serializer: Api::V1::Tracks::TaskSerializer
end
