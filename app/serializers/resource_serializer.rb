class ResourceSerializer < ActiveModel::Serializer
  attributes :id,
             :url,
             :native_name
end
