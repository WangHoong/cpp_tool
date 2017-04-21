class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string "name",                                comment: "语言名称"
    end
  end
end
