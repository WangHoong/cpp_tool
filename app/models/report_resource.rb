class ReportResource < ApplicationRecord
  belongs_to :report
  belongs_to :resource
end