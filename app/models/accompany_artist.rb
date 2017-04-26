class AccompanyArtist < ApplicationRecord
   belongs_to :target, polymorphic: true
   validates :name, presence: true
end
