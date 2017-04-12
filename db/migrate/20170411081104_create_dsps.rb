class CreateDsps < ActiveRecord::Migration[5.0]
  def change
    create_table :dsps do |t|
      t.string   "name",          limit: 100
      t.integer  "department_id"
      t.boolean  "is_agent",                    default: false
      t.string   "contact"
      t.string   "address"
      t.string   "tel"
      t.string   "email"
      t.text     "desc"
      t.timestamps
    end
  end
end
