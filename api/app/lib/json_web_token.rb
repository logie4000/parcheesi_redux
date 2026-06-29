class JsonWebToken
  # secret to encode and decode the token
  HMAC_SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
 
    # sign the token with the application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    begin
      # get payload; first index in decoded library
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body

    rescue JWT::DecodeError => e
      raise ExceptionHandler::InvalidToken, e.message
    end
  end
end
