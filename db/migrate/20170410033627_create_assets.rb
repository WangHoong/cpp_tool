class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer  "target_id"
      t.string   "target_type"
      t.string   "filename"
      t.string   "url"
      t.timestamps
    end
  end
end
