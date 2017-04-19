class CreateArtistResources < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_resources do |t|
      t.integer  "artist_id",                                                                             comment: "艺人ID"
      t.integer  "resource_id",                                                                           comment: "资源ID"
      t.integer  "field",                                                                                 comment: "个人资源区分"
      t.timestamps
    end
  end
end
