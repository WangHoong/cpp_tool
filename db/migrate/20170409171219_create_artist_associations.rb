class CreateArtistAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_associations do |t|
      t.integer :association_id
      t.integer :artist_id
      t.string :association_type 
      t.timestamps
    end
  end
end
