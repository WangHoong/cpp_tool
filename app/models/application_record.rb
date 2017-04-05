class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :db_query, lambda { |field, query| where("#{field.to_s} like ?", "%#{query}%") }
end
