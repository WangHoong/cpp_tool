class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string   :title
      t.string   :isrc,                                                                      comment: "标准录音制品编码"
      t.integer  :status,      default: 0
      t.integer  :language_id,                                                                                            comment: "语种"
      t.string   :genre,                                                                                               comment: "曲风"
      t.integer  :provider_id,                                                                                         comment: "版权方ID"
      t.integer  :contract_id
      t.integer  :authorize_id
      t.datetime :uploaded_at
      t.string   :ost
      t.string   :performer,                                                                                           comment: "演唱"
      t.string   :lyric,                                                                                               comment: "作词"
      t.string   :melody,                                                                                              comment: "作曲"
      t.string   :company
      t.boolean  :is_agent,      default: false
      t.boolean  :deleted,      default: false
      t.string   :harmonic,                                                                          comment: "作曲"
      t.text :remark
      t.timestamps
    end
    add_index :tracks, :title
  end
end
