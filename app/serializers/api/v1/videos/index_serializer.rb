class Api::V1::Videos::IndexSerializer < Api::V1::VideoSerializer
  attributes :artist
  # def tracks_length
  #   object.tracks.size
  # end
  def artist
    @artist = object.primary_artists.first

    {
      name: @artist && @artist['name'] || ''
    }
  end
end
