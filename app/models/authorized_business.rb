class AuthorizedBusiness < ApplicationRecord
    has_and_belongs_to_many :authorized_areas, join_table:'authorized_businesses_areas'
    belongs_to :authorized_range

    def update_authorized_areas_count
         areas_cnt = self.authorized_areas.size
        self.update_attributes!(areas_count: areas_cnt)
    end

    def authorized_range_name
      authorized_range.try(:name)
    end

end
