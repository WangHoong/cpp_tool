class Api::V1::Albums::IndexSerializer < Api::V1::AlbumSerializer
  attributes :tracks_length,
    :artist,
    :audits,
    :updated_at
  def tracks_length
    object.tracks.size
  end
  def artist
    @artist = object.primary_artists.first

    {
      name: @artist && @artist['name'] || ''
    }
  end
end
