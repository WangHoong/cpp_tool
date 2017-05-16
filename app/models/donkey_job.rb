class DonkeyJob < ActiveRecord::Base
  enum task: [:parse_revenue, :distribute]
  enum status: [:pending, :done, :failure]

  belongs_to :target, polymorphic: true

end
