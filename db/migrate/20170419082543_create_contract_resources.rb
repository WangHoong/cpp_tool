class CreateContractResources < ActiveRecord::Migration[5.0]
  def change
    create_table :contract_resources do |t|
      t.integer  "target_id"
      t.string   "target_type"
      t.integer  "resource_id"
      t.integer  "field"
      t.timestamps
    end
    add_index :contract_resources, [:target_id,:target_type]
    add_index :contract_resources, :resource_id
  end
end
