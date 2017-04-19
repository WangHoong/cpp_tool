class ArtistResource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
  belongs_to :resource
  belongs_to :artist
  accepts_nested_attributes_for :resource, :allow_destroy => true
end
