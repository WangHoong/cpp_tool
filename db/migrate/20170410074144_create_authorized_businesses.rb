class CreateAuthorizedBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_businesses do |t|
      t.integer  "authorized_range_id",                                      comment: "授权范围"
      t.integer  "authorize_id",                                             comment: "授权书ID"
      t.string   "divided_point",       limit: 100,                          comment: "分成比例"
      t.integer  "areas_count",                     default: 0
      t.timestamps

    end
  end
end
