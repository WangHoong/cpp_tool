class CreateAccompanyArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :accompany_artists do |t|
      t.string  "name"
      t.integer "target_id"
      t.string  "target_type"
      t.index ["target_id", "target_type"], name: "index_target_id_and_target_type", using: :btree
    end
  end
end
