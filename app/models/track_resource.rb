class TrackResource < ApplicationRecord
  belongs_to :resource
  belongs_to :track 
  accepts_nested_attributes_for :resource, :allow_destroy => true
end
