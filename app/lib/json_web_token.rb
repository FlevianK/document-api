class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, ENV["HMAC_SECRET"].to_s)
  end

  def self.decode(token)
    body = JWT.decode(token, ENV["HMAC_SECRET"].to_s)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => event
    raise ExceptionHandler::InvalidToken, event.message
  end
end