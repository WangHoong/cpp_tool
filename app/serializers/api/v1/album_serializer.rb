class Api::V1::AlbumSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :genre,
    :format,
    :label,
    :status,
    :release_version,
    :remark,
    :upc
end
