class Api::V1::Albums::ShowSerializer < Api::V1::AlbumSerializer
  attributes :tracks_length,
    :release_date,
    :language,
    :has_explict,
    :p_line_copyright,
    :remark,
    :original_label_number,
    :cd_volume,
    :updated_at
  def tracks_length
    object.tracks.size
  end
  has_many :primary_artists, serializer: Api::V1::Albums::ArtistSerializer
  has_many :featuring_artists, serializer: Api::V1::Albums::ArtistSerializer
end
