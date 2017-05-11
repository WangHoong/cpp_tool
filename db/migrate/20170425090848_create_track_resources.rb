class CreateTrackResources < ActiveRecord::Migration[5.0]
  def change
    create_table :track_resources do |t|
      t.integer  "track_id"
      t.string   "file_name"
      t.integer  "file_type", default: 0
      t.string   "url"
      t.timestamps
    end
    add_index :track_resources, :track_id
  end
end
