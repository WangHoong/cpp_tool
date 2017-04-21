class AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre,
    :format,
    :label,
    :release_version,
    :remark,
    :upc

  has_many :primary_artists
  has_many :featuring_artists
  has_many :songs
  has_many :images
  belongs_to :language
  class ArtistSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
  class LanguageSerializer < ActiveModel::Serializer
    attributes :name
  end
end
