class Track < ApplicationRecord

  belongs_to :album
  belongs_to :artist

  validates :name, presence: true
  
  scope :recent, -> { order('id DESC') }

end
