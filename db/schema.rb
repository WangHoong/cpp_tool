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

ActiveRecord::Schema.define(version: 20170620101323) do

  create_table "accompany_artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "target_id"
    t.string  "target_type"
    t.index ["target_id", "target_type"], name: "index_target_id_and_target_type", using: :btree
  end

  create_table "album_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "album_id"
    t.string   "name"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_id"], name: "index_album_names_on_album_id", using: :btree
  end

  create_table "album_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_id"
    t.integer  "album_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "index"
  end

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "upc",                                                              comment: "商品统一编码，universal product code"
    t.integer  "catalog_number",                                                   comment: "专辑编号"
    t.string   "format",                                                           comment: "专辑类型，0: album, 1: EP, 2: Single, 3:Box_Set"
    t.integer  "catalog_tier",                                                     comment: "价格分级，0: Budget, 1: Back, 2: Mid, 3: Front, 4: Premium"
    t.integer  "language_id",                                                      comment: "语言"
    t.string   "genre",                                                            comment: "曲风"
    t.string   "label",                                                            comment: "唱片公司"
    t.datetime "original_release_date",                                            comment: "最初发行日期"
    t.datetime "release_date",                                                     comment: "发行日期"
    t.string   "original_label_number",                                            comment: "原唱片公司编号"
    t.string   "p_line_copyright",                                                 comment: "℗ "
    t.string   "c_line_copyright",                                                 comment: "©"
    t.integer  "has_explict",                                                      comment: "是否包含限制内容，0:no,1:yes,2:clean"
    t.integer  "provider",                                                         comment: "版权方ID"
    t.datetime "uploaded_at"
    t.integer  "upload_method",                                                    comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
    t.integer  "uploader",                                                         comment: "版权方上传经手人"
    t.string   "release_version",                                                  comment: "发行版本"
    t.integer  "total_volume",                                                     comment: "专辑曲目数量"
    t.integer  "cd_volume",                                                        comment: "cd数量"
    t.string   "display_artist",                                                   comment: "艺人显示"
    t.string   "sub_genre",                                                        comment: "子曲风"
    t.date     "recording_year",                                                   comment: "录音时间"
    t.string   "record_location",                                                  comment: "录音地点"
    t.text     "remark",                limit: 65535,                              comment: "备注"
    t.integer  "status",                              default: 0,                  comment: "专辑状态 0: 待审核，1: 已审核"
    t.boolean  "deleted",                             default: false,              comment: "true删除,false未删除"
    t.string   "not_through_reason"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "tracks_count",                        default: 0
    t.index ["name"], name: "index_albums_on_name", using: :btree
    t.index ["status"], name: "index_albums_on_status", using: :btree
  end

  create_table "albums_tracks", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "track_id"
    t.integer "album_id"
    t.index ["album_id"], name: "album_id", using: :btree
    t.index ["track_id"], name: "track_id", using: :btree
  end

  create_table "albums_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "video_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id", "album_id"], name: "index_album_videos_on_video_id_and_album_id", using: :btree
  end

  create_table "artist_albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "album_id"
    t.integer  "artist_id"
    t.string   "album_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "association_id", using: :btree
    t.index ["artist_id"], name: "artist_id", using: :btree
  end

  create_table "artist_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artist_id"], name: "index_artist_names_on_artist_id", using: :btree
  end

  create_table "artist_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "artist_id",                                  comment: "艺人ID"
    t.integer  "resource_id",                                comment: "资源ID"
    t.string   "resource_type",                              comment: "个人资源区分"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "deleted",       default: false
  end

  create_table "artist_tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "track_id"
    t.integer  "artist_id"
    t.string   "artist_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "artist_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "video_id"
    t.integer  "artist_id"
    t.string   "artist_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artist_type"], name: "by_artist_type", length: { artist_type: 10 }, using: :btree
    t.index ["video_id", "artist_id"], name: "index_artist_videos_on_video_id_and_artist_id", using: :btree
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id",                                                        comment: "国籍"
    t.string   "country_name"
    t.integer  "gender_type",                                                       comment: "0男，1女，2组合"
    t.integer  "label_id",                                                          comment: "唱片公司ID"
    t.string   "label_name"
    t.text     "description",            limit: 65535,                              comment: "艺人介绍"
    t.boolean  "deleted",                              default: false,              comment: "true删除,false未删除"
    t.integer  "status",                               default: 0,                  comment: "0待审批 ,1审批通过，2审批未通过"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "not_through_reason"
    t.integer  "multi_language_name_id"
    t.string   "website",                                                           comment: "网站网址"
    t.integer  "tracks_count",                         default: 0
    t.integer  "albums_count",                         default: 0
    t.index ["deleted"], name: "index_artists_on_deleted", using: :btree
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes", limit: 65535
    t.integer  "version",                       default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", length: { associated_type: 25 }, using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", length: { auditable_type: 25 }, using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", length: { request_uuid: 30 }, using: :btree
    t.index ["user_id", "user_type"], name: "user_index", length: { user_type: 25 }, using: :btree
  end

  create_table "authorized_areas", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT" do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorized_businesses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "authorized_range_id",                                      comment: "授权范围"
    t.integer  "authorize_id",                                             comment: "授权书ID"
    t.string   "divided_point",       limit: 100,                          comment: "分成比例"
    t.integer  "areas_count",                     default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "authorized_businesses_areas", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "authorized_business_id", comment: "授权业务"
    t.integer "authorized_area_id",     comment: "区域"
    t.index ["authorized_area_id"], name: "authorized_area_id", using: :btree
    t.index ["authorized_business_id"], name: "authorized_business_id", using: :btree
  end

  create_table "authorized_ranges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "banks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "account_no"
  end

  create_table "continents", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cn_name", limit: 16, comment: "中文名"
    t.string "en_name", limit: 16, comment: "英文名"
  end

  create_table "contract_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "file_name"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["target_id", "target_type"], name: "index_contract_resources_on_target_id_and_target_type", using: :btree
  end

  create_table "copyrights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name",                     comment: "版权最终归属"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "countries", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "continent_id",               comment: "对应七大陆continent表的id"
    t.string  "name",         limit: 256,   comment: "英文常用标准名称，主要用于显示"
    t.string  "lower_name",   limit: 256,   comment: "对应于英文标准名称的小写，主要用于搜索比较"
    t.string  "country_code", limit: 64,    comment: "英文缩写名称，全大写"
    t.string  "full_name",    limit: 256,   comment: "英文标准名称全称"
    t.string  "cname",        limit: 256,   comment: "中文常用标准名称，通常简称"
    t.string  "full_cname",   limit: 256,   comment: "中文全称名称，非缩写"
    t.text    "remark",       limit: 65535, comment: "备注字段，保留"
  end

  create_table "cp_authorizes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "contract_id",                           comment: "合约"
    t.integer  "currency_id",                           comment: "货币"
    t.integer  "account_id",                            comment: "账号ID"
    t.datetime "start_time",                            comment: "开始时间"
    t.datetime "end_time",                              comment: "结算时间"
    t.integer  "tracks_count", default: 0,              comment: "授权歌曲数量"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cp_contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "contract_no",                                                                            comment: "合约编号"
    t.string   "project_no",                                                                             comment: "项目编号"
    t.integer  "provider_id",                                                                            comment: "版权方"
    t.integer  "department_id",                                                                          comment: "部门"
    t.datetime "start_time",                                                                             comment: "合约开始时间"
    t.datetime "end_time",                                                                               comment: "合约结束时间"
    t.boolean  "allow_overdue",                                             default: false,              comment: "是否永久有效"
    t.integer  "pay_type",                                                  default: 0,                  comment: "预付方式"
    t.decimal  "prepay_amount",                    precision: 10, scale: 2, default: "0.0",              comment: "预付金额"
    t.integer  "tracks_count",                                              default: 0,                  comment: "全部授权歌曲数量"
    t.integer  "status",                                                    default: 0,                  comment: "0:未审核1:通过2:未通过"
    t.boolean  "deleted",                                                   default: false,              comment: "0:未删除1:删除"
    t.string   "not_through_reason",                                                                     comment: "未通过原因"
    t.text     "desc",               limit: 65535,                                                       comment: "描述"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  create_table "cp_settlements", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.float    "settlement_amount",      limit: 24,             comment: "结算金额"
    t.date     "settlement_cycle_start",                        comment: "结算周期开始时间"
    t.date     "settlement_cycle_end",                          comment: "结算周期结束时间"
    t.date     "settlement_date",                               comment: "结算日期"
    t.integer  "status",                            default: 0, comment: "结算状态 0 待确认 1待支付2已支付"
    t.integer  "provider_id",                                   comment: "版权方"
    t.integer  "dsp_id",                                        comment: "渠道"
    t.integer  "currency_id",                                   comment: "货币"
    t.string   "file_url",                                      comment: "文件URL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "en_name"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "optype", default: 0, comment: "0:sp,1:cp"
  end

  create_table "donkey_jobs", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT" do |t|
    t.integer  "task",                                 null: false
    t.integer  "target_id",                            null: false
    t.string   "target_type",             default: "", null: false
    t.integer  "status",                  default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at"
    t.string   "note",        limit: 200
  end

  create_table "dsps", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT" do |t|
    t.string   "name",               limit: 100
    t.integer  "outer_id",                                         comment: "DMC SP iD"
    t.integer  "department_id"
    t.integer  "optype",                           default: 0,     comment: "0:全部1:无线2:新媒体3:海外"
    t.boolean  "is_agent",                         default: false
    t.string   "contact"
    t.string   "address"
    t.string   "tel"
    t.string   "email"
    t.text     "desc",               limit: 65535
    t.integer  "status",                           default: 0
    t.string   "not_through_reason"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "event_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "status",                   default: 0
    t.datetime "op_time"
    t.integer  "event_type",               default: 0
    t.text     "content",    limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "exchange_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "currency_id",                                         comment: "货币"
    t.integer  "settlement_currency_id",                              comment: "结算货币"
    t.string   "exchange_ratio",                                      comment: "兑换比例"
    t.integer  "status",                 default: 0,                  comment: "0enabled ,1disabled"
    t.boolean  "deleted",                default: false,              comment: "true删除,false未删除"
    t.string   "operator",                                            comment: "操作员"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",    comment: "语言名称"
    t.string "en_name", comment: "英文"
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT" do |t|
    t.string "name", collation: "utf8_general_ci"
  end

  create_table "multi_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name"
    t.integer  "language_id"
    t.integer  "multilanguage_id"
    t.string   "multilanguage_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["multilanguage_id"], name: "by_multilanguage_id", using: :btree
    t.index ["multilanguage_type"], name: "by_multilanguage_type", length: { multilanguage_type: 10 }, using: :btree
  end

  create_table "permission_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.integer  "sort",           default: 0,              comment: "排序"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["lft"], name: "index_permission_groups_on_lft", using: :btree
    t.index ["parent_id"], name: "index_permission_groups_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_permission_groups_on_rgt", using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "module_name"
    t.integer  "permission_group_id"
    t.integer  "status",              default: 1
    t.integer  "rule_type",           default: 1,              comment: "权限类型(1:查询权限;2:编辑权限;3:审核\b)"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "permissions_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.index ["permission_id"], name: "index_roles_permissions_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_roles_permissions_on_role_id", using: :btree
  end

  create_table "providers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name",               limit: 100
    t.integer  "property",                                                default: 0,                  comment: "属性0:个人1：公司"
    t.string   "contact",                                                                              comment: "联系人"
    t.string   "tel",                                                                                  comment: "联系电话"
    t.string   "address",                                                                              comment: "地址"
    t.string   "email",                                                                                comment: "eamil"
    t.string   "bank_name",                                                                            comment: "开户行"
    t.string   "account_no",                                                                           comment: "卡号"
    t.string   "user_name",                                                                            comment: "账户名"
    t.integer  "cycle",                                                                                comment: "结算周期天"
    t.datetime "start_time",                                                                           comment: "结算开始时间"
    t.integer  "status",                                                  default: 0,                  comment: "0未审核1审核通过2未通过"
    t.boolean  "deleted",                                                 default: false,              comment: "0未删除1删除"
    t.decimal  "current_amount",                 precision: 10, scale: 2, default: "0.0",              comment: "余额"
    t.integer  "copyright_id",                                                                         comment: "最终版权"
    t.string   "not_through_reason",                                                                   comment: "未通过原因"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",                                      comment: "资源url"
    t.boolean  "deleted",     default: false,              comment: "true删除,false未删除"
    t.string   "native_name",                              comment: "资源原始名称"
    t.integer  "position",                                 comment: "位置,用户各资源排序"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["deleted"], name: "index_resources_on_deleted", using: :btree
    t.index ["position"], name: "position", using: :btree
  end

  create_table "revenue_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "revenue_id"
    t.string   "file_name"
    t.string   "url"
    t.datetime "processed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "revenues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dsp_id"
    t.integer  "user_id"
    t.integer  "currency_id"
    t.date     "start_time"
    t.date     "end_time"
    t.float    "income",         limit: 24, default: 0.0
    t.integer  "status",                    default: 0
    t.integer  "process_status",            default: 0
    t.boolean  "is_std",                    default: false
    t.boolean  "is_split",                  default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["dsp_id"], name: "index_reports_on_dsp_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
    t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "album_id",                            comment: "专辑 ID"
    t.integer  "status",     default: 0,              comment: "状态 0：未处理，1：已完成，2：处理中，-1：失败"
    t.string   "message",                             comment: "失败原因"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["album_id", "status"], name: "index_tasks_on_album_id_and_status", using: :btree
  end

  create_table "track_composers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "point"
    t.integer  "track_id"
    t.string   "op_type",                 comment: "工作类型"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_track_composers_on_track_id", using: :btree
  end

  create_table "track_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "track_id"
    t.string   "file_name"
    t.integer  "file_type",  default: 0
    t.string   "url"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["track_id"], name: "index_track_resources_on_track_id", using: :btree
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "isrc",                                                          comment: "标准录音制品编码"
    t.integer  "status",                           default: 0
    t.integer  "language_id",                                                   comment: "语种"
    t.integer  "genre_id"
    t.datetime "uploaded_at"
    t.integer  "position",                                                      comment: "歌曲在专辑中的顺序"
    t.string   "ost"
    t.string   "lyric",                                                         comment: "作词"
    t.string   "label",                                                         comment: "唱片公司"
    t.string   "label_code",                                                    comment: "唱片公司编号"
    t.string   "pline"
    t.string   "cline",                            default: "",    null: false
    t.boolean  "is_agent",                         default: false,              comment: "是否代理"
    t.integer  "provider_id",                                                   comment: "版权方ID"
    t.integer  "contract_id"
    t.integer  "authorize_id"
    t.integer  "copyright_id",                                                  comment: "版权最终归属"
    t.boolean  "deleted",                          default: false
    t.text     "remark",             limit: 65535,                              comment: "备注"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "not_through_reason",                                            comment: "未通过原因"
    t.string   "release_version",                                               comment: "版本"
    t.index ["position"], name: "position", using: :btree
    t.index ["title"], name: "index_tracks_on_title", using: :btree
  end

  create_table "tracks_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "video_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "provider_id"
    t.decimal  "amount",      precision: 11, scale: 2, default: "0.0",              comment: "结算金额"
    t.decimal  "balance",     precision: 11, scale: 2, default: "0.0",              comment: "当前余额"
    t.integer  "status",                               default: 0,                  comment: "待支付：0 已支付1"
    t.string   "subject",                                                           comment: "摘要"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "sort",                                 default: 1
    t.datetime "pay_time"
    t.datetime "updated_at",                                           null: false
    t.datetime "created_at",                                           null: false
    t.index ["provider_id"], name: "provider_id", using: :btree
    t.index ["target_id", "target_type"], name: "traget_index", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "address",         limit: 65535
    t.string   "avatar_url"
    t.integer  "status",                        default: 0,                  comment: "0:未审核1:审核通过2:未通过"
    t.boolean  "deleted",                       default: false
    t.string   "password_digest"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_admin",                      default: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  create_table "video_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "resource_id"
    t.integer  "video_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_id"], name: "by_resource_id", using: :btree
    t.index ["resource_type"], name: "by_resource_type", length: { resource_type: 10 }, using: :btree
    t.index ["video_id"], name: "by_video_id", using: :btree
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name",                                                          comment: "名称"
    t.integer  "format",                                                        comment: "类型"
    t.string   "label",                                                         comment: "唱片公司"
    t.datetime "release_date",                                                  comment: "发行日期"
    t.string   "remark",                                                        comment: "备注"
    t.integer  "status",                           default: 0,                  comment: "pending,accepted,rejected"
    t.boolean  "deleted",                          default: false,              comment: "true删除,false未删除"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.text     "not_through_reason", limit: 65535,                              comment: "未通过原因"
    t.integer  "tracks_count",                     default: 0
    t.index ["name"], name: "by_name", length: { name: 10 }, using: :btree
  end

end
