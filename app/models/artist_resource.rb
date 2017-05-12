class ArtistResource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
  belongs_to :resource
  belongs_to :artist
end
