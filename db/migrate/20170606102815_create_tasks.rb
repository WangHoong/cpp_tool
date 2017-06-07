class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :source_id,                                                     comment: "资源 ID"
      t.integer :source_type,                                                   comment: "资源类型"
      t.integer :status,        default: 0,                                     comment: "状态 0：未处理，1：已完成，2：处理中，-1：失败"
      t.string :message,                                                        comment: "失败原因"
      t.timestamps
    end
  end
end
