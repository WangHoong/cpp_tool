class Language < ApplicationRecord
  has_one :language, :foreign_key => :language_id
end
