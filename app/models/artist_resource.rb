class ArtistResource < ApplicationRecord
  belongs_to :resource
  belongs_to :artist
  accepts_nested_attributes_for :resource, :allow_destroy => true
end
