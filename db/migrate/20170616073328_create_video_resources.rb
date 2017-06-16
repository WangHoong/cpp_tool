class CreateVideoResources < ActiveRecord::Migration[5.0]
  def change
    create_table :video_resources do |t|
      t.integer :resource_id
      t.integer :video_id
      t.string  :resource_type
      t.timestamps
    end
    add_index :video_resources, :resource_id, name: "by_resource_id"
    add_index :video_resources, :video_id, name: "by_video_id"
    add_index :video_resources, :resource_type, name: "by_resource_type", length: 10

  end
end
