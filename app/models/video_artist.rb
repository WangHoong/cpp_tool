class VideoArtist < ApplicationRecord
  belongs_to :artist
  belongs_to :video
end
