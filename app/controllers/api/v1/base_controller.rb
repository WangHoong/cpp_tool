class Api::V1::BaseController < ApplicationController

  before_action :authenticate_user!
  attr_accessor :current_user

  protected

  def authenticate_user!
    authenticate
    return unauthenticated! unless @current_user
  end

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

  def rsa_public_encrypt
    encrypt = Encrypt.new
    q_time = Time.now.to_i * 1000
    json = {ids: "123",q_time: q_time}.to_json
    public_key = Rails.application.secrets.public_key
    publickey = OpenSSL::PKey::RSA.new(Base64.decode64(public_key))
    original = encrypt.rsa_public_encrypt(json,publickey)
    result = Base64.encode64(original).gsub!("\n",'')
    result = CGI.escape(result)
    uri =  "#{Rails.application.secrets.th_url}/offline/track/assetidrel.json?q_source=#{Rails.application.secrets.q_source}&p_json_dig=#{result}"
    re = RestClient.get(uri)
    JSON.parse(re)
  end


end
