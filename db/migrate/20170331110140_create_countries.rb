class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.integer  "continent_id",                                                                             comment: "对应七大陆continent表的id"
      t.string   "name",                                                                                     comment: "英文常用标准名称，主要用于显示"
      t.string   "lower_name",                                                                               comment: "对应于英文标准名称的小写，主要用于搜索比较"
      t.string   "country_code",                                                                             comment: "英文缩写名称，全大写"
      t.string   "full_name",                                                                                comment: "英文标准名称全称"
      t.string   "cname",                                                                                    comment: "中文常用标准名称，通常简称"
      t.string   "full_cname",                                                                               comment: "中文全称名称，非缩写"
      t.text     "remark",                                                                                   comment: "备注字段，保留"
    end
  end
end
