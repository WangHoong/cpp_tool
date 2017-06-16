class CreateAlbumResources < ActiveRecord::Migration[5.0]
  def change
    create_table :album_resources do |t|
      t.integer :resource_id
      t.integer :album_id
      t.string  :resource_type
      t.timestamps
    end
    add_index :album_resources, :resource_id
    add_index :album_resources, :album_id
    add_index :album_resources, :resource_type
  end
end
