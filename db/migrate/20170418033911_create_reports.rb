class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer  "dsp_id"
      t.integer  "currency_id"
      t.date     "start_time"
      t.date     "end_time"
      t.decimal  "income",         precision: 10, scale: 2, default: "0.0"
      t.integer  "status",                                  default: 0
      t.integer  "process_status",                          default: 0
      t.boolean  "is_std",                                  default: false
      t.boolean  "is_split",                                default: false
 
      t.timestamps
    end
  end
end
