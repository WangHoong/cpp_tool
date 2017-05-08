class CreatePermissionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :permission_groups do |t|
      t.string :name
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      t.integer :sort, default: 0, comment: "排序"
      t.timestamps
    end
  end
end
