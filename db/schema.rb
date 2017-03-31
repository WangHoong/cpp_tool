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

ActiveRecord::Schema.define(version: 20170330110818) do

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id",                                            comment: "国籍"
    t.string   "country"
    t.string   "avatar",                      default: "",              comment: "个人写真"
    t.integer  "provider_id",                                           comment: "版权方ID"
    t.date     "uploaded_at"
    t.integer  "upload_method",                                         comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
    t.string   "label"
    t.string   "website",                                               comment: "网站"
    t.text     "biography",     limit: 65535,                           comment: "艺人介绍"
    t.integer  "genre_id",                                              comment: "曲风"
    t.integer  "postal_code",                                           comment: "邮政编码"
    t.string   "contact",                                               comment: "联系方式"
    t.string   "alias",                                                 comment: "别名"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

end
