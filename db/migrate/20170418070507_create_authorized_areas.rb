class CreateAuthorizedAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_areas do |t|
        t.string   "name" 
        t.timestamps
    end
  end
end
