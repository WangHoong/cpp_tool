class CreateAuthorizedBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_businesses do |t|
      t.integer  "business_id",                                    comment: "业务名称"
      t.string   "business_type",                                  default: "Business"
      t.integer  "target_id",                                      comment: "授权书ID"
      t.string   "target_type",   limit: 100,                      comment: "授权书类型"
      t.integer  "lyrics_point",                                   comment: "词比例"
      t.integer  "tune_point",                                     comment: "曲比例"
      t.string   "divided_point", limit: 100,                      comment: "分成比例"
      t.integer  "areas_count",               default: 0
      t.boolean  "is_define",     limit: 1,   default: 0,          comment: "是否自定义分成比例"
      t.string   "define_point",  limit: 100,                      comment: "自定义分成比例"
      t.boolean  "is_whole",                  default: false
      t.timestamps

    end
  end
end
