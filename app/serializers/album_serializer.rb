class AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre,
    :format

  has_many :primary_artists
  has_many :featuring_artists
  belongs_to :language
  class ArtistSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
  class LanguageSerializer < ActiveModel::Serializer
    attributes :name
  end
end
