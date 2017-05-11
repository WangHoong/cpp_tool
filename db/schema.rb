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

ActiveRecord::Schema.define(version: 20170509031253) do

  create_table "accompany_artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "target_id"
    t.string  "target_type"
    t.index ["target_id", "target_type"], name: "index_target_id_and_target_type", using: :btree
  end

  create_table "album_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_id"
    t.integer  "album_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.string   "p_line_copyright",                                                 comment: "℗ "
    t.string   "c_line_copyright",                                                 comment: "©"
    t.boolean  "has_explict",                                                      comment: "是否包含限制内容，0:no,1:yes,2:clean"
    t.integer  "provider",                                                         comment: "版权方ID"
    t.datetime "uploaded_at"
    t.integer  "upload_method",                                                    comment: "上传方式,0: user_upload, 1: user_batch_upload, 2: op_upload, 3: DDEX, 4: other"
    t.integer  "uploader",                                                         comment: "版权方上传经手人"
    t.string   "release_version",                                                  comment: "发行版本"
    t.integer  "total_volume",                                                     comment: "专辑曲目数量"
    t.string   "display_artist",                                                   comment: "艺人显示"
    t.string   "sub_genre",                                                        comment: "子曲风"
    t.date     "recording_year",                                                   comment: "录音时间"
    t.string   "record_location",                                                  comment: "录音地点"
    t.text     "remark",                limit: 65535,                              comment: "备注"
    t.integer  "status",                              default: 0,                  comment: "专辑状态 0: 待审核，1: 已审核"
    t.boolean  "deleted",                             default: false,              comment: "true删除,false未删除"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["name"], name: "index_albums_on_name", using: :btree
    t.index ["status"], name: "index_albums_on_status", using: :btree
  end

  create_table "albums_tracks", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "track_id"
    t.integer "album_id"
    t.index ["album_id"], name: "album_id", using: :btree
    t.index ["track_id"], name: "track_id", using: :btree
  end

  create_table "approves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "status",                                        comment: "审批状态,pending,accepted,rejected"
    t.string   "target_type",                                   comment: "类型"
    t.integer  "target_id"
    t.string   "creator",                                       comment: "录入者"
    t.datetime "approve_at",                                    comment: "审批时间"
    t.string   "approver",                                      comment: "审批人"
    t.text     "not_through_reason", limit: 65535,              comment: "未通过原因"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "artist_associations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "association_id"
    t.integer  "artist_id"
    t.string   "association_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["artist_id"], name: "artist_id", using: :btree
    t.index ["association_id"], name: "association_id", using: :btree
  end

  create_table "artist_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "artist_id",                                comment: "艺人ID"
    t.integer  "resource_id",                              comment: "资源ID"
    t.integer  "field",                                    comment: "个人资源区分"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "deleted",     default: false
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id",                                                    comment: "国籍"
    t.string   "country_name"
    t.integer  "gender_type",                                                   comment: "0男，1女，2组合"
    t.integer  "label_id",                                                      comment: "唱片公司ID"
    t.string   "label_name"
    t.text     "description",        limit: 65535,                              comment: "艺人介绍"
    t.boolean  "deleted",                          default: false,              comment: "true删除,false未删除"
    t.string   "status",                           default: "0",                comment: "0待审批 ,1审批通过，2审批未通过"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "not_through_reason"
    t.index ["deleted"], name: "index_artists_on_deleted", using: :btree
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "artists_tracks", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "track_id"
    t.integer "artist_id"
    t.index ["artist_id"], name: "index_artists_tracks_on_artist_id", using: :btree
    t.index ["track_id"], name: "index_artists_tracks_on_track_id", using: :btree
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

  create_table "continents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cn_name", comment: "中文名字"
    t.string "en_name", comment: "英文名字"
  end

  create_table "contract_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "resource_id"
    t.integer  "field",                    comment: "field: \"0:图片,1:音频,2:歌词,3:视频\""
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["resource_id"], name: "index_contract_resources_on_resource_id", using: :btree
    t.index ["target_id", "target_type"], name: "index_contract_resources_on_target_id_and_target_type", using: :btree
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
    t.string   "contract_no",                                                                       comment: "合约编号"
    t.string   "project_no",                                                                        comment: "项目编号"
    t.integer  "provider_id",                                                                       comment: "版权方"
    t.integer  "department_id",                                                                     comment: "部门"
    t.datetime "start_time",                                                                        comment: "合约开始时间"
    t.datetime "end_time",                                                                          comment: "合约结束时间"
    t.boolean  "allow_overdue",                                        default: false,              comment: "是否永久有效"
    t.integer  "pay_type",                                             default: 0,                  comment: "预付方式"
    t.decimal  "pay_amount",                  precision: 10, scale: 2, default: "0.0",              comment: "预付金额"
    t.integer  "tracks_count",                                         default: 0,                  comment: "全部授权歌曲数量"
    t.integer  "status",                                               default: 0,                  comment: "0:未审核1:通过2:未通过"
    t.boolean  "deleted",                                              default: false,              comment: "0:未删除1:删除"
    t.string   "reason",                                                                            comment: "未通过原因"
    t.text     "desc",          limit: 65535,                                                       comment: "描述"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "cp_settlements", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT" do |t|
    t.float    "settlement_amount",      limit: 24,                          comment: "结算金额"
    t.date     "settlement_cycle_start",                                     comment: "结算周期开始时间"
    t.date     "settlement_cycle_end",                                       comment: "结算周期结束时间"
    t.date     "settlement_date",                                            comment: "结算日期"
    t.integer  "settlement_status",                 default: 0,              comment: "结算状态 0 待确认 1待支付2已支付"
    t.integer  "provider_id",                                                comment: "版权方"
    t.integer  "dsp_id",                                                     comment: "渠道"
    t.integer  "currency_id",                       default: 1, null: false, comment: "货币"
    t.string   "file_url",                                                   comment: "文件URL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", comment: "名称"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "optype", default: 0, comment: "0:sp,1:cp"
  end

  create_table "dsps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name",          limit: 100
    t.integer  "department_id"
    t.boolean  "is_agent",                    default: false
    t.string   "contact"
    t.string   "address"
    t.string   "tel"
    t.string   "email"
    t.text     "desc",          limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "exchange_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "currency",                                         comment: "货币"
    t.string   "settlement_currency",                              comment: "结算货币"
    t.string   "exchange_ratio",                                   comment: "兑换比例"
    t.integer  "status",              default: 0,                  comment: "0enabled ,1disabled"
    t.boolean  "deleted",             default: false,              comment: "true删除,false未删除"
    t.string   "operator",                                         comment: "操作员"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", comment: "语言名称"
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
    t.string   "name",       limit: 100
    t.integer  "property",               default: 0,                  comment: "属性0:个人1：公司"
    t.string   "contact",                                             comment: "联系人"
    t.string   "tel",                                                 comment: "联系电话"
    t.string   "address",                                             comment: "地址"
    t.string   "email",                                               comment: "eamil"
    t.string   "bank_name",                                           comment: "开户行"
    t.string   "account_no",                                          comment: "卡号"
    t.string   "user_name",                                           comment: "账户名"
    t.integer  "cycle",                                               comment: "结算周期天"
    t.datetime "start_time",                                          comment: "结算开始时间"
    t.integer  "status",                 default: 0,                  comment: "0未审核1审核通过2未通过"
    t.boolean  "deleted",                default: false,              comment: "0未删除1删除"
    t.string   "reason",                                              comment: "未通过原因"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "report_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "report_id"
    t.string   "file_name"
    t.string   "url"
    t.datetime "processed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dsp_id"
    t.integer  "currency_id"
    t.date     "start_time"
    t.date     "end_time"
    t.decimal  "income",         precision: 10, scale: 2, default: "0.0"
    t.integer  "status",                                  default: 0
    t.integer  "process_status",                          default: 0
    t.boolean  "is_std",                                  default: false
    t.boolean  "is_split",                                default: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["dsp_id"], name: "index_reports_on_dsp_id", using: :btree
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",                                      comment: "资源url"
    t.boolean  "deleted",     default: false,              comment: "true删除,false未删除"
    t.string   "native_name",                              comment: "资源原始名称"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["deleted"], name: "index_resources_on_deleted", using: :btree
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

  create_table "sp_authorizes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "contract_id",                                         comment: "合约"
    t.integer  "currency_id",                                         comment: "货币"
    t.integer  "bank_id",                                             comment: "银行名称"
    t.string   "account_no",     limit: 100,                          comment: "账号"
    t.datetime "start_time",                                          comment: "开始时间"
    t.datetime "end_time",                                            comment: "结算时间"
    t.integer  "authorize_type",                                      comment: "授权类型"
    t.integer  "tracks_count",               default: 0,              comment: "歌曲数量"
    t.integer  "company_count",              default: 0,              comment: "授权公司数量"
    t.string   "tracks_file",                                         comment: "授权歌曲报表文件"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "sp_contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "department_id",                            comment: "单位部门"
    t.integer  "dsp_id",                                   comment: "渠道"
    t.string   "project_no",      limit: 100,              comment: "项目编号"
    t.string   "contract_no",     limit: 100,              comment: "合约编号"
    t.string   "signing_company",                          comment: "签约公司"
    t.datetime "start_time",                               comment: "合约开始时间"
    t.datetime "end_time",                                 comment: "合约结算时间"
    t.integer  "pay_type",                                 comment: "支付类型"
    t.integer  "pay_amount",                               comment: "预付金额"
    t.string   "desc",                                     comment: "描述"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
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

  create_table "track_contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "track_id"
    t.integer  "contract_id"
    t.integer  "authorize_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "track_resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "track_id"
    t.string   "file_name"
    t.integer  "resource_type", default: 0
    t.string   "url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["track_id"], name: "index_track_resources_on_track_id", using: :btree
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "isrc",                                                    comment: "标准录音制品编码"
    t.integer  "status",                     default: 0
    t.integer  "language_id",                                             comment: "语种"
    t.string   "genre",                                                   comment: "曲风"
    t.datetime "uploaded_at"
    t.string   "ost"
    t.string   "lyric",                                                   comment: "作词"
    t.string   "label",                                                   comment: "唱片公司"
    t.boolean  "is_agent",                   default: false,              comment: "是否代理"
    t.integer  "provider_id",                                             comment: "版权方ID"
    t.integer  "contract_id"
    t.integer  "authorize_id"
    t.boolean  "deleted",                    default: false
    t.text     "remark",       limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["title"], name: "index_tracks_on_title", using: :btree
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

end
