class Api::V1::Videos::IndexSerializer < Api::V1::VideoSerializer
  attributes :artist,
    :auditer,
    :tracks_count

  def auditer
      object.audits.first.try(:username)
  end

  def artist
      object.primary_artists.first.try(:name)
  end
end
