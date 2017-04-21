module Bce
  class Sts
    def initialize(ak, sk)
      @ak = ak
      @sk = sk
      @expired_at   = 60 * 60 * 24
      @endpoint     = 'http://sts.bj.baidubce.com'
    end

    def get_session_token
      request = RestClient.post(gw_url,{accessControlList: [{service: 'bce:bos',resource:'dmc_media_dev',region: '*',effect: 'Allow',permission: ['READ', 'WRITE']}]}) #rescue nil
      p request
      return JSON.parse(request) unless request.nil?
    end


    private


    def gw_url
      "#{@endpoint}" + "/v1/sessionToken"
    end


  end

end
