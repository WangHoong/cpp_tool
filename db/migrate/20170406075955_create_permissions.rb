class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string  :name
      t.string  :module_name
      t.integer :permission_group_id
      t.string  :rule_type,  comment: "权限类型(1:查询权限;2:编辑权限;3:审核)"
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
