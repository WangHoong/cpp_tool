class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string   "name"
      t.integer  "type",       default: 0,              comment: "0:sp,1:cp"
     
    end
  end
end
