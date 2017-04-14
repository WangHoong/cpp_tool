class Resource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'string', :deleted_value => 1
  belongs_to :target, polymorphic: true
  #default_scope -> { where(deleted: false) }
end
