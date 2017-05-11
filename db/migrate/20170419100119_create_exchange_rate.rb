class CreateExchangeRate < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.string   "currency_id",                                                                               comment: "货币"
      t.string  "settlement_currency_id",                                                                     comment: "结算货币"
      t.string  "exchange_ratio",                                                                          comment: "兑换比例"
      t.integer  "status"           ,default: 0,                                                           comment: "0enabled ,1disabled"
      t.boolean  "deleted",         default: false,                                                        comment: "true删除,false未删除"
      t.string   "operator",                                                                               comment: "操作员"
      t.timestamps
    end
  end
end
