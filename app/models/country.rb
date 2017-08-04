class Country < ApplicationRecord
    has_many :artist
    belongs_to :continent
    default_scope -> { order(sort: :desc) }

end
