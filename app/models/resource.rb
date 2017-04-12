class Resource < ApplicationRecord
  enum status: [:disabled,:enabled]
  acts_as_paranoid :column => 'status', :column_type => 'string', :deleted_value => 0
  belongs_to :target, polymorphic: true
  default_scope -> { where(status: :enabled) }
end
