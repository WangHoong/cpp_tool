class CreateContractResources < ActiveRecord::Migration[5.0]
  def change
    create_table :contract_resources do |t|
      t.integer  "target_id"
      t.string   "target_type"
      t.string   "url"
      t.string   "file_name"
      t.timestamps
    end
    add_index :contract_resources, [:target_id,:target_type]
  end
end
