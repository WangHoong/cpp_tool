class CreatePermissionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :permission_groups do |t|
      t.string  :name
      t.integer :sort, default: 0, comment: "排序"
      t.timestamps
    end
  end
end
