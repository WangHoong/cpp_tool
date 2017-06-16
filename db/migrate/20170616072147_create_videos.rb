class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :name, comment: "名称"
      t.integer :format, comment: "类型"
      t.string :label, comment: "唱片公司"
      t.datetime :release_date, comment: "发行日期"
      t.string :remark, comment: "备注"
      t.integer :status ,default: 0, comment: "pending,accepted,rejected"
      t.boolean :deleted, default: false, comment:"true删除,false未删除"
      t.text :not_through_reason, limit: 65535, comment: "未通过原因"
      t.timestamps
    end
    add_index :videos, :name, name: 'by_name', length: 10
  end
end
