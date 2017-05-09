class CountrySerializer < ActiveModel::Serializer
  attributes :id,
    :continent,
    :name,
    :lower_name,
    :country_code,
    :full_name,
    :cname,
    :full_cname,
    :remark
end
