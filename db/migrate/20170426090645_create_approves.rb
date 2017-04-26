class CreateApproves < ActiveRecord::Migration[5.0]
  def change
    create_table :approves do |t|
      t.string   "status",                                                                                 comment: "审批状态,pending,accepted,rejected"
      t.string  "target_type",                                                                        comment: "类型"
      t.integer   "target_id"
      t.string  "creator",                                                                                 comment: "录入者"
      t.datetime  "approve_at",                                                                             comment: "审批时间"
      t.string   "approver",                                                                               comment: "审批人"
      t.text     "not_through_reason",        limit: 65535,                                                comment: "未通过原因"
      t.timestamps
    end
  end
end
