class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string   "name"
      t.integer  "country_id",                                                                             comment: "国籍"
      t.string   "country_name"
      t.integer  "gender_type",                                                                            comment: "0男，1女，2组合"
      t.integer  "label_id",                                                                               comment: "唱片公司ID"
      t.string   "label_name"
      t.integer  "multi_language_name_id"
      t.string   "website"
      t.text     "description",        limit: 65535,                                                       comment: "艺人介绍"
      t.boolean  "deleted",         default: false,                                                        comment: "true删除,false未删除"
      t.string   "status"               ,default: 0,                                                       comment: "pending,accepted,rejected"
      t.text     "not_through_reason",        limit: 65535,                                                comment: "未通过原因"
      t.timestamps
    end
      add_index :artists, :name
      add_index :artists, :deleted
  end
end
