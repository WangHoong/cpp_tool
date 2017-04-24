class Api::V1::StsController < Api::V1::BaseController
  #skip_load_and_authorize_resource
  skip_before_action :authenticate_user!


 def  media_token
   @sts = Bce::Sts.new(Rails.application.secrets[:bos_ak],Rails.application.secrets[:bos_sk],Rails.application.secrets[:dmc_media])
   res = @sts.get_session_token
   render json: res
 end

 def  ro_token
   @sts = Bce::Sts.new(Rails.application.secrets[:bos_ak],Rails.application.secrets[:bos_sk],Rails.application.secrets[:dmc_ro])
   res = @sts.get_session_token
   render json: res
 end


end
