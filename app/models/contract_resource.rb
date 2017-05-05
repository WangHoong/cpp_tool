class ContractResource < ApplicationRecord
  belongs_to :resource
  belongs_to :target, polymorphic: true
  accepts_nested_attributes_for :resource, :allow_destroy => true

  def resource_url
     self.resource.try(:url)
  end
end
