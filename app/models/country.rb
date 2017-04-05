class Country < ApplicationRecord
    has_many :artist
    belongs_to :continent
end
