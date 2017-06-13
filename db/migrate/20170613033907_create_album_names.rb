class CreateAlbumNames < ActiveRecord::Migration[5.0]
  def change
    create_table :album_names do |t|
      t.integer "album_id"
      t.string "name"
      t.integer "language_id"
      t.timestamps
    end
    add_index :album_names, [:album_id]
  end
end
