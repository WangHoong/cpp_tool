class CreateReportResources < ActiveRecord::Migration[5.0]
  def change
    create_table :report_resources do |t|
      t.integer :resource_id
      t.integer :report_id
    end
  end
end
