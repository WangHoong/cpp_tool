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

ActiveRecord::Schema.define(version: 20170331110140) do

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id",                                            comment: "国籍"
    t.string   "country_name"
    t.integer  "gender_type"
    t.integer  "label_id",                                              comment: "唱片公司ID"
    t.string   "label_name"
    t.text     "biography",      limit: 65535,                          comment: "艺人介绍"
    t.integer  "status",                       default: 1,              comment: "0删除 ，1未删除"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "operator",                                              comment: "操作员"
    t.integer  "approve_status",               default: 0, null: false, comment: "0到审批 ,1审批通过，2审批未通过"
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "continent_id",               comment: "对应七大陆continent表的id"
    t.string  "name",                       comment: "英文常用标准名称，主要用于显示"
    t.string  "lower_name",                 comment: "对应于英文标准名称的小写，主要用于搜索比较"
    t.string  "country_code",               comment: "英文缩写名称，全大写"
    t.string  "full_name",                  comment: "英文标准名称全称"
    t.string  "cname",                      comment: "中文常用标准名称，通常简称"
    t.string  "full_cname",                 comment: "中文全称名称，非缩写"
    t.text    "remark",       limit: 65535, comment: "备注字段，保留"
  end

end
