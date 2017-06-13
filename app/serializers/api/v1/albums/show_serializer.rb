class Api::V1::Albums::ShowSerializer < Api::V1::AlbumSerializer
  attributes :tracks_length,
    :primary_artists,
    :featuring_artists,
    :release_date,
    :has_explict,
    :language,
    :p_line_copyright,
    :remark,
    :original_label_number,
    :album_names,
    :cd_volume,
    :updated_at
  def tracks_length
    object.tracks.size
  end
  def primary_artists
    @primary_artists = object.primary_artists
  end
  def featuring_artists
    @featuring_artists = object.featuring_artists
  end
end
