class CreateCpContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :cp_contracts do |t|
      t.string   "contract_no",                                                                comment: "合约编号"
      t.string   "project_no",                                                                 comment: "项目编号"
      t.integer  "provider_id",                                                               comment: "版权方"
      t.integer  "department_id",                                                              comment: "部门"
      t.datetime "start_time",                                                                 comment: "合约开始时间"
      t.datetime "end_time",                                                                   comment: "合约结束时间"
      t.boolean  "allow_overdue",                                              default: false, comment: "是否永久有效"
      t.integer  "pay_type",                                                   default: 0,     comment: "预付方式"
      t.decimal  "pay_amount",                        precision: 10, scale: 2, default: "0.0", comment: "预付金额"
      t.integer  "tracks_count",                                               default: 0,     comment: "全部授权歌曲数量"
      t.integer  "status",                                                     default: 0,     comment: "0:未审核1:通过2:未通过"
      t.integer  "is_deleted",                                                     default: 0,     comment: "1:删除0:未删除"
      t.text     "desc"
      t.timestamps
    end
  end
end
