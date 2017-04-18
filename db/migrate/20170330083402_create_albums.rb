class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string   "name"
      t.string   "upc",                                             comment: "商品统一编码，universal product code"
      t.integer  "catalog_number",                                  comment: "专辑编号"
      t.string   "format",                                          comment: "专辑类型，0: album, 1: EP, 2: Single, 3:Box_Set"
      t.integer  "catalog_tier",                                    comment: "价格分级，0: Budget, 1: Back, 2: Mid, 3: Front, 4: Premium"
      t.integer  "language_id",                                     comment: "语言"
      t.integer  "genre_id",                                        comment: "曲风"
      t.integer  "label_id",                                        comment: "唱片公司ID"
      t.datetime "original_release_date",                           comment: "最初发行日期"
      t.string   "p_line_copyright",                                comment: "℗ "
      t.string   "c_line_copyright",                                comment: "©"
      t.boolean  "has_explict",                                     comment: "是否包含限制内容，0:no,1:yes,2:clean"
      t.integer  "provider",                                        comment: "版权方ID"
      t.datetime "uploaded_at"
      t.integer  "upload_method",                                   comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
      t.integer  "uploader",                                        comment: "版权方上传经手人"
      t.string   "release_version",                                 comment: "发行版本"
      t.integer  "total_volume",                                    comment: "专辑曲目数量"
      t.string   "display_artist",                                  comment: "艺人显示"
      t.integer  "sub_genre",                                       comment: "子曲风"
      t.date     "recording_year",                                  comment: "录音时间"
      t.string   "record_location",                                 comment: "录音地点"
      t.integer  "status",        index: true, default: 0,          comment: "专辑状态 0: 待审核，1: 已审核"
      t.datetime "deleted_at",                                      comment: "删除时间"
      t.timestamps
    end
    add_index :albums, :name
  end
end
