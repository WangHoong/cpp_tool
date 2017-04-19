class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer  "target_id"
      t.string   "target_type"
      t.string   "filename"
      t.string   "url"
      t.timestamps
      t.index ["target_id", "target_type"], name: "index_assets_on_target_id_and_target_type", using: :btree
    end
  end
end
