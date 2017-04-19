class AuthorizedBusiness < ApplicationRecord
    belongs_to :business_type, polymorphic: true

    has_and_belongs_to_many :authorized_areas, join_table:'authorized_businesses_areas'
    #default_scope -> { includes(:business,:authorized_areas) }



    def update_authorized_areas_count
         areas_cnt = self.authorized_areas.size
        self.update_attributes!(areas_count: areas_cnt)
    end

end
