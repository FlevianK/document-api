class JsonWebToken
  HMAC_SECRET = "843bee5f5fbd8fd71d07613e0e376086"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => event
    raise ExceptionHandler::InvalidToken, event.message
  end
end