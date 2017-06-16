class Api::V1::TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :message,
    :status,
    :created_at,
    :updated_at
  belongs_to :album, serializer: Api::V1::Albums::ShowSerializer
    # class AlbumSerializer < ActiveModel::Serializer
    #   attributes :id,
    #     :name,
    #     :genre,
    #     :format,
    #     :label,
    #     :release_version,
    #     :remark,
    #     :upc,
    #     :materials,
    #     :covers,
    #     :language,
    #     :primary_artists,
    #     :featuring_artists,
    #   has_many :tracks, serializer: Api::V1::Albums::ArtistSerializer
    # end
end
