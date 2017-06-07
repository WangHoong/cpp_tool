class CreateArtistNames < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_names do |t|
      t.integer "artist_id"
      t.string "name"
      t.string "language_name"
      t.timestamps
    end
    add_index :artist_names, [:artist_id]
  end
end
