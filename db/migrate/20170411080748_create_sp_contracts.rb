class CreateSpContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :sp_contracts do |t|
      t.integer  "department_id",                   comment: "单位部门"
      t.integer  "dsp_id",                          comment: "渠道"
      t.string   "project_no",          limit: 100, comment: "项目编号"
      t.string   "contract_no",         limit: 100, comment: "合约编号"
      t.string   "signing_company",                 comment: "签约公司"
      t.datetime "start_time",             comment: "合约开始时间"
      t.datetime "end_time",               comment: "合约结算时间"
      t.integer  "pay_type",                        comment: "支付类型"
      t.integer  "pay_amount",                      comment: "预付金额"
      t.string   "desc",                            comment: "描述"
      t.timestamps
    end
  end
end
