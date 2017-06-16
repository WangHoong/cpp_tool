class CreateVideosTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :videos_tracks do |t|
      t.integer :video_id
      t.integer :track_id
      t.timestamps
    end
  end
end
