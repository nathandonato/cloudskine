# frozen_string_literal: true

require 'jwt'

# This class is responsible for encoding and decoding JWTs for authentication
class JwtManager
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token)
    # Parameters are token, public key, whether to validate or not, then
    # what to validate
    JWT.decode(token, HMAC_SECRET, true, algorithm: ALGORITHM)
  end
end
