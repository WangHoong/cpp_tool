class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string   :title
      t.string   :isrc,                                                                      comment: "标准录音制品编码"
      t.integer  :language_id,                                                                                            comment: "语种"
      t.string   :genre,                                                                                               comment: "曲风"
      t.integer  :provider_id,                                                                                         comment: "版权方ID"
      t.integer  :contract_id
      t.integer  :authorize_id
      t.datetime :uploaded_at
      t.string   :ost
      t.string   :lyric,                                                                                               comment: "作词"
      t.string   :label
      t.string   :copyright_attribution, comment: "版权最终归属"
      t.integer  :position,       comment: "位置, 在专辑中的顺序"
      t.boolean  :is_agent,      default: false
      t.boolean  :deleted,      default: false
      t.string   :status               ,default: 0,                                                       comment: "pending,accepted,rejected"
      t.text     :not_through_reason,        limit: 65535,                                                comment: "未通过原因"
      t.text :remark
      t.timestamps
    end
    add_index :tracks, :title
  end
end
