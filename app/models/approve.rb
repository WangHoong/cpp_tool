class Approve < ApplicationRecord
  belongs_to :target, polymorphic: true
end
