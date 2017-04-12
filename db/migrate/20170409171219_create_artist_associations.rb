class CreateArtistAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_associations do |t|
      t.integer :association_id, index: true
      t.integer :artist_id, index: true
      t.string :association_type, index: true
      t.timestamps
    end
  end
end
