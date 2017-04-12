class CreateSpAuthorizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sp_authorizes do |t|
      t.integer  "contract_id",                            comment: "合约"
      t.integer  "currency_id",                            comment: "货币"
      t.integer  "bank_id",                                comment: "银行名称"
      t.string   "account_no",     limit: 100,             comment: "账号"
      t.datetime "start_time",                             comment: "开始时间"
      t.datetime "end_time",                               comment: "结算时间"
      t.integer  "authorize_type",                         comment: "授权类型"
      t.integer  "tracks_count",               default: 0, comment: "歌曲数量"
      t.integer  "company_count",              default: 0, comment: "授权公司数量"
      t.string   "tracks_file",                            comment: "授权歌曲报表文件"
      t.timestamps
    end
  end
end
