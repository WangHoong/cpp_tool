class CreateAlbumResources < ActiveRecord::Migration[5.0]
  def change
    create_table :album_resources do |t|
      t.integer :resource_id
      t.integer :album_id
      t.string  :resource_type
      t.timestamps
    end
  end
end
