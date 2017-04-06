class AddArtistToAlbums < ActiveRecord::Migration[5.0]
  def change
    change_table :albums do |t|
      t.string   "label_id",                                        comment: "唱片公司 id"
      t.string   "primary_artist",                                  comment: "主唱"
      t.integer  "primary_artist_id",                               comment: "主唱ID"
      t.string   "featuring_artist",                                comment: "伴唱"
      t.integer  "featuring_artist_id",                             comment: "伴唱ID"
    end
  end
end
