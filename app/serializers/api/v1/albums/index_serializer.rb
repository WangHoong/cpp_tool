class Api::V1::Albums::IndexSerializer < Api::V1::AlbumSerializer
  attributes  :artist,
    :tracks_count,
    :auditer,
    :updated_at

    def auditer
        object.audits.first.try(:username)
    end

  def artist
    @artist = object.primary_artists.first
    {
      name: @artist.try(:name)
    }
  end
end
