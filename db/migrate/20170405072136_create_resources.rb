class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string  "url",                     comment: "资源url"
      t.boolean "deleted", default: false, comment: "true删除,false未删除"
      t.string  "native_name",             comment: "资源原始名称"
      t.string  "position",                comment: "位置,用户各资源排序"
      t.timestamps
    end
    add_index :resources, :deleted
    add_index :resources, :position  
  end
end
