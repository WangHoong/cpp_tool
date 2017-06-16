class ArtistVideo < ApplicationRecord
  belongs_to :artist
  belongs_to :video
end
