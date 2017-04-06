class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.integer  "target_id",                                                                             comment: "目标ID"
      t.string   "target_type",                                                                           comment: "目标类型"
      t.string   "url",                                                                                   comment: "资源url"
      t.integer  "status"
      t.string   "native_name",                                                                           comment: "资源原始名称"
      t.integer  "field",                                                                                 comment: "个人资源区分"
      t.timestamps
    end
      add_index :resources, [:target_type, :target_id]
  end
end
