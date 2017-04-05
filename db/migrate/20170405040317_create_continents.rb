class CreateContinents < ActiveRecord::Migration[5.0]
  def change
    create_table :continents do |t|
      t.string   "cn_name",                                                                 comment: "中文名字"
      t.string   "en_name",                                                                 comment: "英文名字"
    end
  end
end
