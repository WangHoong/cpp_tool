class CreateArtistsTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :artists_tracks,id: false do |t|
      t.integer "track_id"
      t.integer "artist_id"

    end
    add_index :artists_tracks, :track_id
    add_index :artists_tracks, :artist_id
  end
end
