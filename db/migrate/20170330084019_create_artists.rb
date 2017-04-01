class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string   "name"
      t.integer  "country_id",                                                                             comment: "国籍"
      t.string   "country"
      t.string   "avatar",                                                                                 comment: "个人写真"
      t.integer  "provider_id",                                                                            comment: "版权方ID"
      t.date     "uploaded_at"
      t.integer  "upload_method",                                                                          comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
      t.string   "label"
      t.string   "website",                                                                                comment: "网站"
      t.text     "biography",                                                           comment: "艺人介绍"
      t.integer  "genre_id",                                                                               comment: "曲风"
      t.integer  "postal_code",                                                                            comment: "邮政编码"
      t.string   "contact",                                                                                comment: "联系方式"
      t.string   "alias",                                                                                  comment: "别名"
      t.timestamps
    end
      add_index :artists, :name
  end
end
