class Resource < ApplicationRecord
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean', :allow_nulls => false
<<<<<<< HEAD
  belongs_to :target, polymorphic: true
=======
  has_many :artist_resources
  has_many :artists, through: :artist_resources

>>>>>>> 9fba351e2344dbe8914c251a7ebaac8dca8c4660
end
