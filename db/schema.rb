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

ActiveRecord::Schema.define(version: 20170405102144) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
    t.string   "label_id",                           comment: "唱片公司 id"
    t.string   "primary_artist",                     comment: "主唱"
    t.integer  "primary_artist_id",                  comment: "主唱ID"
    t.string   "featuring_artist",                   comment: "伴唱"
    t.integer  "featuring_artist_id",                comment: "伴唱ID"
    t.index ["name"], name: "index_albums_on_name", using: :btree
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "country_id",                                            comment: "国籍"
    t.string   "country_name"
    t.integer  "gender_type",                                           comment: "0男，1女，2组合"
    t.integer  "label_id",                                              comment: "唱片公司ID"
    t.string   "label_name"
    t.text     "description",    limit: 65535,                          comment: "艺人介绍"
    t.integer  "status",                       default: 1,              comment: "0删除 ，1未删除"
    t.string   "operator",                                              comment: "操作员"
    t.integer  "approve_status",               default: 0,              comment: "0待审批 ,1审批通过，2审批未通过"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "continents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cn_name", comment: "中文名字"
    t.string "en_name", comment: "英文名字"
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "continent_id",               comment: "对应七大陆continent表的id"
    t.string  "name",                       comment: "英文常用标准名称，主要用于显示"
    t.string  "lower_name",                 comment: "对应于英文标准名称的小写，主要用于搜索比较"
    t.string  "country_code",               comment: "英文缩写名称，全大写"
    t.string  "full_name",                  comment: "英文标准名称全称"
    t.string  "cname",                      comment: "中文常用标准名称，通常简称"
    t.string  "full_cname",                 comment: "中文全称名称，非缩写"
    t.text    "remark",       limit: 65535, comment: "备注字段，保留"
  end

<<<<<<< HEAD
  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id",                comment: "目标ID"
    t.string   "target_type",              comment: "目标类型"
    t.string   "url",                      comment: "资源url"
    t.integer  "status"
    t.string   "native_name",              comment: "资源原始名称"
    t.integer  "field",                    comment: "个人资源区分"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["target_type", "target_id"], name: "index_resources_on_target_type_and_target_id", using: :btree
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

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
