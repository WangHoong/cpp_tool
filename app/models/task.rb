class Task < ApplicationRecord
  belongs_to :album
  accepts_nested_attributes_for :album

  def album_name
    album.try(:name)
  end

  def album_upc
   album.try(:upc)
  end

  def self.as_list_json_options
     as_list_json = {
    			only: [:id, :album_id,:status,:message,:created_at,:updated_at],
          methods: [:album_name,:album_upc]
        }
  end
end
