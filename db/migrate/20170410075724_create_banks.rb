class CreateBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :banks do |t|
      t.string   :name
      t.string   :account_no
    end
  end
end
