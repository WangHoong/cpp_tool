class ContractResource < ApplicationRecord
  belongs_to :target, polymorphic: true
 
end
