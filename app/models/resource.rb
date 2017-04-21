class Resource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
  has_many :artist_resources
  has_many :artists, through: :artist_resources
end
