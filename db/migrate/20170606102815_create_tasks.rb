class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :album_id,                                                     comment: "专辑 ID"
      t.integer :status,        default: 0,                                     comment: "状态 0：未处理，1：已完成，2：处理中，-1：失败"
      t.string :message,                                                        comment: "失败原因"
      t.timestamps
    end
    add_index :tasks, [:album_id, :status]
  end
end
