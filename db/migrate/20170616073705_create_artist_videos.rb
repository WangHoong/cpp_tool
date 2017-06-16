class CreateArtistVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_videos do |t|
      t.integer :video_id
      t.integer :artist_id
      t.string :artist_type
      t.timestamps
    end
    add_index :artist_videos, [:video_id, :artist_id]
    add_index :artist_videos, :artist_type, name: 'by_artist_type', length: 10
  end
end
