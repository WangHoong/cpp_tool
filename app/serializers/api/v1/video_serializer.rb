class Api::V1::VideoSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :format,
    :label,
    :release_date,
    :status,
    :remark,
    :created_at,
    :updated_at
end
