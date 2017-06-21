module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do

    rescue_from Exception do |e|
      Raven.capture_exception(e)
      raise e
      json_response({err_code: 500, message: e.message}, 500)
    end
  end
end