class Resource < ApplicationRecord
    belongs_to :target, polymorphic: true
end