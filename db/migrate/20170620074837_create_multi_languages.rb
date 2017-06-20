class CreateMultiLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :multi_languages do |t|
      t.string :name
      t.integer :language_id
      t.integer :multilanguage_id
      t.string  :multilanguage_type
      t.timestamps
    end
    add_index :multi_languages, :multilanguage_id, name: "by_multilanguage_id"
    add_index :multi_languages, :multilanguage_type, name: "by_multilanguage_type", length: 10
  end
end
