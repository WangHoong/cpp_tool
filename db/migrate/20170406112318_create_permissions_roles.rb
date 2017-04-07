class CreatePermissionsRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions_roles , id: false do |t|
      t.integer "role_id"
      t.integer "permission_id"
      t.index ["role_id"], name: "index_roles_permissions_on_role_id", using: :btree
      t.index ["permission_id"], name: "index_roles_permissions_on_permission_id", using: :btree
    end
  end
end
