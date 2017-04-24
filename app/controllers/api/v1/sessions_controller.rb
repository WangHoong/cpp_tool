class Api::V1::SessionsController < Api::V1::BaseController
  #skip_load_and_authorize_resource
  skip_before_action :authenticate_user!

  def create
    @user = User.find_by_email session_params[:email]
    if @user && @user.authenticate(session_params[:password])
      token = Auth.gen_token payload_for_user(@user)
      exp_days = (Auth::DEFAULT_EXPIRATION / 24 / 3600.0).round(1)
      render json: {access_token: token, expired_in_days: exp_days}, status: :ok
    else
      render json: {status: 401, error: "Incorrect email or password"}, status: :unauthorized
    end
  end

 def sts_token
   @sts = Bce::Sts.new(Rails.application.secrets[:bos_ak],Rails.application.secrets[:bos_sk])
   res = @sts.get_session_token
   render json: res
 end

  private
  def session_params
    params.permit(:email, :password)
  end

end
