class CreateTrackResources < ActiveRecord::Migration[5.0]
  def change
    create_table :track_resources do |t|
      t.integer  "resource_id"
      t.integer  "track_id"
      t.integer  "field"
      t.timestamps
    end
    add_index :track_resources, :track_id
    add_index :track_resources, :resource_id
  end
end
