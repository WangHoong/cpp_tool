class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
        t.string   "name",          limit: 100
        t.integer  "property",     default: 0,                             comment: "属性0:个人1：公司"
        t.string   "contact",                            comment: "联系人"
        t.string   "tel",                                comment: "联系电话"
        t.string   "address",                            comment: "地址"
        t.string   "email",                              comment: "eamil"
        t.string   "bank_name",                          comment: "开户行"
        t.string   "account_no",                         comment: "卡号"
        t.string   "user_name",                          comment: "账户名"
        t.integer  "cycle",                              comment: "结算周期"
        t.integer  "status",          default: 0,        comment: "0未审核1审核通过2未通过"
        t.boolean  "deleted",         default: false,    comment: "0未删除1删除"
        t.string   "reason",                             comment: "未通过原因"
        t.datetime "start_time",                         comment: "结算开始时间"
        t.timestamps
    end
  end
end
