class CreateTrackVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :track_videos do |t|
      t.integer :video_id
      t.integer :track_id
      t.timestamps
    end
    add_index :track_videos, [:video_id, :track_id]
  end
end
