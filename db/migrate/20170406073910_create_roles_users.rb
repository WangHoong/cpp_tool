class CreateRolesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_users, id: false do |t|
        t.integer "user_id"
        t.integer "role_id"
        t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
        t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
    end
  end
end
