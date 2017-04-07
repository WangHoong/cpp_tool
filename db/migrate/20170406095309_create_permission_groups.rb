class CreatePermissionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :permission_groups do |t|
      t.string  :name
      t.integer :parent_id, default: 0
      t.integer :sort, default: 0, comment: "排序"
      t.timestamps
    end
  end
end
