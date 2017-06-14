class RevenueFile < ApplicationRecord
  belongs_to :revenue
  validates :url, presence: true
  
end
