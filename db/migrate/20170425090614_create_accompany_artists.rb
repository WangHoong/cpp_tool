class CreateAccompanyArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :accompany_artists do |t|
      t.string  "name"
      t.integer "target_id"
      t.string  "target_type"
    end
    add_index :accompany_artists, [:target_id,:target_type]
  end
end
