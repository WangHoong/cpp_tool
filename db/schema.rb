# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170330084019) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "upc",                                comment: "商品统一编码，universal product code"
    t.integer  "catalog_number",                     comment: "专辑编号"
    t.integer  "format",                             comment: "专辑类型，0: album, 1: EP, 2: Single, 3:Box_Set"
    t.integer  "catalog_tier",                       comment: "价格分级，0: Budget, 1: Back, 2: Mid, 3: Front, 4: Premium"
    t.integer  "language",                           comment: "语言"
    t.integer  "genre",                              comment: "曲风"
    t.string   "label"
    t.datetime "original_release_date",              comment: "最初发行日期"
    t.string   "p_line_copyright",                   comment: "℗ "
    t.string   "c_line_copyright",                   comment: "©"
    t.boolean  "has_explict",                        comment: "是否包含限制内容，0:no,1:yes,2:clean"
    t.string   "cover",                              comment: "专辑封面"
    t.integer  "provider_id",                        comment: "版权方ID"
    t.datetime "uploaded_at"
    t.integer  "upload_method",                      comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
    t.integer  "uploader_id",                        comment: "版权方上传经手人"
    t.string   "release_version",                    comment: "发行版本"
    t.integer  "total_volume",                       comment: "专辑曲目数量"
    t.string   "display_artist",                     comment: "艺人显示"
    t.integer  "sub_genre",                          comment: "子曲风"
    t.date     "recording_year",                     comment: "录音时间"
    t.string   "record_location",                    comment: "录音地点"
    t.integer  "alternative_genre",                  comment: "另类曲风"
    t.integer  "alternative_sub_genre",              comment: "另类子曲风"
    t.string   "complication"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name"], name: "index_albums_on_name", using: :btree
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id",                               comment: "国籍"
    t.string   "country"
    t.string   "avatar",                                   comment: "个人写真"
    t.integer  "provider_id",                              comment: "版权方ID"
    t.date     "uploaded_at"
    t.integer  "upload_method",                            comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
    t.string   "label"
    t.string   "website",                                  comment: "网站"
    t.text     "biography",     limit: 65535,              comment: "艺人介绍"
    t.integer  "genre_id",                                 comment: "曲风"
    t.integer  "postal_code",                              comment: "邮政编码"
    t.string   "contact",                                  comment: "联系方式"
    t.string   "alias",                                    comment: "别名"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.integer  "artist_id"
    t.integer  "album_id"
    t.text     "audio_url",   limit: 65535
    t.integer  "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["album_id"], name: "index_tracks_on_album_id", using: :btree
    t.index ["artist_id"], name: "index_tracks_on_artist_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "address",         limit: 65535
    t.string   "avatar_url"
    t.integer  "status",                        default: 0
    t.string   "password_digest"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

end
