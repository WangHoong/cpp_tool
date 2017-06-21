class Task < ApplicationRecord
  belongs_to :album
  accepts_nested_attributes_for :album
end
