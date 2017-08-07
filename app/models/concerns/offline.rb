class Offline

  def tracks(options)
    result = get_result(options)
    uri = "#{Rails.application.secrets.th_url}/offline/track/assetidrel.json?q_source=#{Rails.application.secrets.q_source}&p_json_dig=#{result}"
    re = RestClient.get(uri)
    JSON.parse(re)
  end

  def track_detail(options)
    result = get_result(options)
    uri =  "#{Rails.application.secrets.th_url}/offline/track/detail.json?q_source=#{Rails.application.secrets.q_source}&p_json_dig=#{result}"
    re = RestClient.get(uri)
    JSON.parse(re)
  end

  def getreport(options)
    result = get_result(options)
    uri =  "#{Rails.application.secrets.th_url}/offline/getreport.json?q_source=#{Rails.application.secrets.q_source}&p_json_dig=#{result}"
    re = RestClient.get(uri)
    JSON.parse(re)
  end

  def album_detail(options)
    result = get_result(options)
    uri =  "#{Rails.application.secrets.th_url}/offline/album/detail.json?q_source=#{Rails.application.secrets.q_source}&p_json_dig=#{result}"
    re = RestClient.get(uri)
    JSON.parse(re)
  end



  def get_result(options)
    encrypt = Encrypt.new
    q_time = Time.now.to_i * 1000
    json = {q_time: q_time}.merge(options).to_json
    public_key = Rails.application.secrets.public_key
    publickey = OpenSSL::PKey::RSA.new(Base64.decode64(public_key))
    original = encrypt.rsa_public_encrypt(json,publickey)
    result = Base64.encode64(original).gsub!("\n",'')
    return CGI.escape(result)
  end

end
