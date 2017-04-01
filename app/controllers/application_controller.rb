class ApplicationController < ActionController::API
  def meta_attributes(object)
    {
        page: object.current_page,
        total: object.total_count
    }
  end
end
