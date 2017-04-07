class Resource < ApplicationRecord
  enum status: [:disabled,:enabled]
  belongs_to :target, polymorphic: true
  default_scope -> { where(status: :enabled) }
end
