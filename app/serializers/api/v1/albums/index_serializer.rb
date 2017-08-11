class Api::V1::Albums::IndexSerializer < Api::V1::AlbumSerializer
  attributes  :artist,
    :tracks_count,
    :updated_at


  def artist
    @artist = object.primary_artists.first

    {
      name: @artist.try(:name)
    }
  end
end
