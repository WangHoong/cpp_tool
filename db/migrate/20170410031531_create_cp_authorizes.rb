class CreateCpAuthorizes < ActiveRecord::Migration[5.0]
  def change
    create_table :cp_authorizes do |t|
      t.integer  "contract_id",              comment: "合约"
      t.integer  "currency_id",              comment: "货币"
      t.integer  "account_id",               comment: "账号ID"
      t.datetime "start_time",               comment: "开始时间"
      t.datetime "end_time",                 comment: "结算时间"
      t.integer  "tracks_count", default: 0, comment: "授权歌曲数量"
      t.timestamps
    end
  end
end
