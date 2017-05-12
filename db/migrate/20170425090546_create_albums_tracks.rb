class CreateAlbumsTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :albums_tracks, id: false do |t|
      t.integer "track_id"
      t.integer "album_id"
     
    end
      add_index :albums_tracks, :track_id
      add_index :albums_tracks, :album_id
  end
end
