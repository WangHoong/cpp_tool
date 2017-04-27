module Bce
  class Sts

    END_POINT = 'https://sts.bj.baidubce.com'
    EXPIRATION = 1800

    def initialize(ak, sk,bucket)
      @ak = ak
      @sk = sk
      @expiration   = EXPIRATION
      @endpoint     = END_POINT
      @uri = '/v1/sessionToken'
      @bucket = bucket
    end

    def get_session_token
      signature = sign('POST', @uri, {}, {host: @endpoint.split('://')[-1]})
      request = RestClient.post("#{@endpoint}#{@uri}", {
                  accessControlList: [
                    {
                      service: 'bce:bos',
                      resource:["#{@bucket}/*"],
                      region: '*',
                      effect: 'Allow',
                      permission: ['READ', 'WRITE']
                    }
                  ]
                }.to_json, headers = {
                  authorization: signature,
                  :content_type => "application/json"
                }) #rescue nil
      return JSON.parse(request) unless request.nil?
    end

    def sign(method, uri, params, headers)
      digest = OpenSSL::Digest.new('sha256')
      time = Time.at(Time.now.to_i).utc.strftime('%FT%TZ')

      sign_key_prefix = "bce-auth-v1/#{@ak}/#{time}/#{@expiration}"
      sign_key = OpenSSL::HMAC.hexdigest digest, @sk, sign_key_prefix

      http_method = method
      canonical_uri = uri
      canonical_query_string = query_string(params)
      canonical_headers = headers_string(headers)

      string_to_sign = [http_method,
        canonical_uri,
        canonical_query_string,
        canonical_headers].join("\n")

      sign_result = OpenSSL::HMAC.hexdigest digest, sign_key, string_to_sign

      "#{sign_key_prefix}/host/#{sign_result}"
    end

    private
    def headers_string(headers)
      permitted_headers = ['host', 'content-md5', 'content-length', 'content-type']

      signed_headers = []
      headers.each do |k, v|
        if permitted_headers.include?(k.to_s) || k.to_s.start_with?('x-bce')
          signed_headers << "#{encode(k.to_s.downcase)}:#{encode(v.to_s)}"
        end
      end

      signed_headers.compact.sort.join('\n')
    end

    def query_string(params)
      signed_query = []
      params.each do |k, v|
        signed_query << "#{encode(k.to_s)}=#{encode_except_slash(v.to_s)}"
      end

      signed_query.compact.sort.join('&')
    end

    def encode(string)
      URI.encode(string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def encode_except_slash(string)
      encode(string).gsub(%r{/}, '%2F')
    end

  end

end
