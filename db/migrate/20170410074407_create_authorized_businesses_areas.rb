class CreateAuthorizedBusinessesAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_businesses_areas, id: false  do |t|
      t.integer "authorized_business_id", comment: "授权业务"
      t.integer "authorized_area_id",     comment: "区域"
      t.index ["authorized_area_id"], name: "authorized_area_id", using: :btree
      t.index ["authorized_business_id"], name: "authorized_business_id", using: :btree
    end
  end
end
