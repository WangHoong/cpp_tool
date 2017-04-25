class CreateAlbumsTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :albums_tracks, id: false do |t|
      t.integer "track_id"
      t.integer "album_id"
      t.index ["album_id"], name: "album_id", using: :btree
      t.index ["track_id"], name: "track_id", using: :btree
    end
      add_index :albums_tracks, :track_id
      add_index :albums_tracks, :album_id
  end
end
