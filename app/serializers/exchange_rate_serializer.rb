class ExchangeRateSerializer < ActiveModel::Serializer
  attributes  :id,
              :currency,
              :settlement_currency,
              :exchange_ratio,
              :status,
              :operator,
              :created_at,
              :updated_at
end
