class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :label_id,
             :label_name,
             :gender_type,
             :description,
             :deleted,
             :website,
             :country,
             :songs,
             :albums,
             :images,
             :audits,
             :created_at,
             :updated_at
  has_many :artist_names
  class ArtistNameSerializer < ActiveModel::Serializer
    attributes :name, :language_name
    def language_name
      object.language.try(:name)
    end
  end

end
