class Report < ApplicationRecord
  enum status: [:processing, :processed, :confirmed, :accounted, :done]

  validates :dsp_id, presence: true

  belongs_to :dsp

end
