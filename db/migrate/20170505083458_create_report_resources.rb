class CreateReportResources < ActiveRecord::Migration[5.0]
  def change
    create_table :report_resources do |t|
      t.integer  "report_id"
      t.string   "file_name"
      t.string   "url"
      t.datetime "processed_at"
      t.timestamps
    end
  end
end
