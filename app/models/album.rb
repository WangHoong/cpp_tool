class Album < ApplicationRecord
  validates :name, presence: true
  validates_inclusion_of :genre, in: CONSTANTS['genres'].keys, allow_nil: true

  scope :recent, -> { order('id DESC') }

end
