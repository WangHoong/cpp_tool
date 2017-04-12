class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
        t.string   "name",          limit: 100
        t.string   "property",                               comment: "属性"
        t.string   "data_type",                               comment: "数据类型"
        t.string   "contact",                            comment: "联系人"
        t.string   "tel",                                comment: "联系人"
        t.string   "address",                            comment: "地址"
        t.string   "email",                              comment: "eamil"
        t.string   "bank_name",                          comment: "开户行"
        t.string   "account_no",                          comment: "账户"
        t.string   "user_name",                          comment: "账户名"
        t.integer  "cycle",                          comment: "结算周期"
        t.datetime   "start_time",                          comment: "结算开始时间"
        t.timestamps
    end
  end
end
