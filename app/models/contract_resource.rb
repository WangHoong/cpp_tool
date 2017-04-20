class ContractResource < ApplicationRecord
  belongs_to :resource
  belongs_to :target, polymorphic: true
  accepts_nested_attributes_for :resource, :allow_destroy => true
end
