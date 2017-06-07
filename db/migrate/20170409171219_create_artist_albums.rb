class CreateArtistAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_albums do |t|
      t.integer :album_id
      t.integer :artist_id
      t.string :album_type
      t.timestamps
    end
    add_index :artist_albums, [:album_id, :artist_id, :album_type]
  end
end
