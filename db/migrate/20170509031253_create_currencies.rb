class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string   :name,                                                                      comment: "名称"
    end
  end
end
