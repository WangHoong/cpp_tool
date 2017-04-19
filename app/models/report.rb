class Report < ApplicationRecord
  enum status: [:processing, :processed, :confirmed, :accounted, :done]

  validates :dsp_id, presence: true

  belongs_to :dsp

  has_many :report_resources
  has_many :files, through: :report_resources, class_name: 'Resource', source: :resource

end
