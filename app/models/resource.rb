class Resource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
  belongs_to :target, polymorphic: true

end
