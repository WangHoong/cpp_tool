class Auth

  ALGORITHM = "HS256"
  DEFAULT_EXPIRATION = 24 * 3600

  def self.gen_token(payload)
    payload[:exp] = Time.now.to_i + DEFAULT_EXPIRATION

    JWT.encode(payload, self.secret, ALGORITHM)
  end

  def self.payload(token)
    decoded_token = JWT.decode(token, self.secret, true, {algorithm: ALGORITHM}) rescue nil
    decoded_token.present? ? decoded_token.first : nil
  end

  private
  def self.secret
    Rails.application.secrets.secret_key_base[0..63]
  end

end