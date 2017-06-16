class Api::V1::Albums::TaskSerializer < Api::V1::AlbumSerializer
  attributes :tracks_length,
    :release_date,
    :language,
    :has_explict,
    :p_line_copyright,
    :remark,
    :original_label_number,
    :album_names,
    :cd_volume,
    :updated_at
  def tracks_length
    object.tracks.size
  end
  has_many :primary_artists, serializer: Api::V1::Albums::ArtistSerializer
  has_many :featuring_artists, serializer: Api::V1::Albums::ArtistSerializer
  has_many :tracks, serializer: Api::V1::Tracks::TaskSerializer
end
