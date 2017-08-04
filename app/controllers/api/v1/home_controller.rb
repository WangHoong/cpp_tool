class Api::V1::HomeController < Api::V1::BaseController
  #skip_load_and_authorize_resource
  skip_before_action :authenticate_user!

  def index
      api_error(status: 404)
  end

  def inbox_messages
      api_error(status: 404)
  end

end
