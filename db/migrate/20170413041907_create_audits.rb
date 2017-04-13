class CreateAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :audits do |t|
      t.integer  "auditable_id"
      t.string   "auditable_type"
      t.integer  "associated_id"
      t.string   "associated_type"
      t.integer  "user_id"
      t.string   "user_type"
      t.string   "username"
      t.string   "action"
      t.text     "audited_changes", limit: 65535
      t.integer  "version",                       default: 0
      t.string   "comment"
      t.string   "remote_address"
      t.string   "request_uuid"
      t.datetime "created_at"
      t.index ["associated_id", "associated_type"], name: "associated_index", length: {"associated_id"=>nil, "associated_type"=>25}, using: :btree
      t.index ["auditable_id", "auditable_type"], name: "auditable_index", length: {"auditable_id"=>nil, "auditable_type"=>25}, using: :btree
      t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
      t.index ["request_uuid"], name: "index_audits_on_request_uuid", length: {"request_uuid"=>30}, using: :btree
      t.index ["user_id", "user_type"], name: "user_index", length: {"user_id"=>nil, "user_type"=>25}, using: :btree
    
    end
  end
end
