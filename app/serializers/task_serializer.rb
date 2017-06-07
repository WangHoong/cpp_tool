class TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :album,
    :message,
    :status,
    :created_at,
    :updated_at
  belongs_to :album
end
