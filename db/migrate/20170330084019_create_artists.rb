class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string   "name"
      t.integer  "country_id",                                                                             comment: "国籍"
      t.string   "country_name"
      t.integer  "gender_type",                                                                            comment: "0男，1女，2组合"
      t.integer  "label_id",                                                                               comment: "唱片公司ID"
      t.string   "label_name"
      t.text     "description",     limit: 65535,                                                          comment: "艺人介绍"
      t.integer  "status"                       ,default: 1,                                               comment: "0删除 ，1未删除"
      t.string   "operator",                                                                               comment: "操作员"
      t.integer  "approve_status"               ,default: 0,                                               comment: "0待审批 ,1审批通过，2审批未通过"
      t.timestamps
    end
      add_index :artists, :name
  end
end
