class CreateRevenueFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :revenue_files do |t|
      t.integer  "revenue_id"
      t.string   "file_name"
      t.string   "url"
      t.datetime "processed_at"
      t.timestamps
    end
  end
end
