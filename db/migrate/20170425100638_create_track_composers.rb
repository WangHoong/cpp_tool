class CreateTrackComposers < ActiveRecord::Migration[5.0]
  def change
    create_table :track_composers do |t|
      t.string :name
      t.integer :point
      t.integer :track_id
      t.string :op_type,  comment: "工作类型"
      t.timestamps
    end
      add_index :track_composers, :track_id
  end
end
