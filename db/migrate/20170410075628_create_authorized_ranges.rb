class CreateAuthorizedRanges < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_ranges do |t|
      t.string   :name
    end
  end
end
