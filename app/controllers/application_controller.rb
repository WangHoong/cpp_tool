class ApplicationController < ActionController::Base

    include Response
    include ExceptionHandler

    # Authorization related methods and callbacks
    #include CanCan::ControllerAdditions
    #include ActionController::Cookies
    #before_action :authenticate_user!
    # load_and_authorize_resource
    #skip_before_action :verify_authenticity_token
    #attr_accessor :current_user
    # catch all authorization failed exceptions
    rescue_from CanCan::AccessDenied do |exception|
        render json: {status: 403, error: exception}, status: :forbidden
    end

    # disable cookies (no set-cookies header in response)
    before_action :destroy_session

    def destroy_session
      request.session_options[:skip] = true
    end

    def page_info(resources)
      {
        page: resources.current_page,
        total: resources.total_count
      }
    end

    def api_error(opts = {})
        render head: true, status: opts[:status]
    end
end
