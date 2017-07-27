class Api::V1::TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :message,
    :status,
    :created_at,
    :updated_at
  belongs_to :album, include: :all, serializer: Api::V1::Albums::TaskSerializer
end
