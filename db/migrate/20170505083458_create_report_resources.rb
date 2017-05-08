class CreateReportResources < ActiveRecord::Migration[5.0]
  def change
    create_table :report_resources do |t|
      t.integer :report_id
      t.integer :field
      t.integer :resource_id
      t.timestamps
    end
  end
end
