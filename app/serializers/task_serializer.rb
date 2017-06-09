class TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :message,
    :status,
    :created_at,
    :updated_at
    belongs_to :album
    class AlbumSerializer < ActiveModel::Serializer
      attributes :id,
        :name,
        :genre,
        :format,
        :label,
        :release_version,
        :remark,
        :upc,
        :materials,
        :covers,
        :language,
        :primary_artists,
        :featuring_artists
    end
end
