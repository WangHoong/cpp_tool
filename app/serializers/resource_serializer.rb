class ResourceSerializer < ActiveModel::Serializer
  attributes :id,
             :url,
             :native_name,
             :field
end
