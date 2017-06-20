class CreateAlbumsVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :albums_videos do |t|
      t.integer :video_id
      t.integer :album_id
      t.timestamps
    end
    add_index :albums_videos, [:video_id, :album_id]
  end
end
