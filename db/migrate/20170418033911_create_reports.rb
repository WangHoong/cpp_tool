class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :user
      t.references :dsp

      t.date :start_time
      t.date :end_time
      t.float :income
      t.integer :status

      t.boolean :is_std
      t.boolean :is_split

      t.timestamps
    end
  end
end
