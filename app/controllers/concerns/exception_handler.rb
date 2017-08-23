module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do

    rescue_from Exception do |e|
      Raven.capture_exception(e)
      raise e if Rails.env == 'development'
      json_response({err_code: 500, message: e}, 500)
    end
  end
end