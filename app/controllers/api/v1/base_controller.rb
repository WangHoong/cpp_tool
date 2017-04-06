class Api::V1::BaseController < ApplicationController

  protected

  def authenticate
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    @current_user ||= User.first
    #@current_user ||= user_in_payload Auth.payload(token)
  end

  #def access_token
  #  request.headers["Authorization"] || params[:access_token] || cookies["accessToken"]
  #end

  # transcode access token payload format
  def user_in_payload payload
    User.find(payload["uid"]) rescue nil
  end

  def payload_for_user user
    {uid: user.id}
  end

  def unauthenticated!
    api_error(status: 401)
  end


end