class Genre < ApplicationRecord
    scope :roots, -> { where(parent_id: 0) }
    scope :sub_genres,-> {where.not(parent_id: 0)}
end
