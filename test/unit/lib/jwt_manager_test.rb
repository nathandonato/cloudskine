# frozen_string_literal: true

require 'test_helper'
require 'jwt'
require 'jwt_manager'

class JwtManagerTest < ActiveSupport::TestCase
  setup do
    @encode_payload = { user_id: 0, email: 'foo@bar.com' }
  end

  test 'successful encode' do
    actual = JwtManager.encode(@encode_payload)
    assert_equal 3, actual.split('.').count
  end

  test 'successful decode' do
    jwt = JwtManager.encode(@encode_payload)
    payload, header = JwtManager.decode(jwt).map(&:with_indifferent_access)

    assert_equal 0, payload[:user_id]
    assert_equal 'foo@bar.com', payload[:email]
    assert_equal JwtManager::ALGORITHM, header[:alg]
  end

  test 'wrong public key' do
    assert_decode_error do
      jwt = raw_encode(@encode_payload, 'foobar', JwtManager::ALGORITHM)
      JwtManager.decode(jwt)
    end
  end

  test 'wrong algorithm' do
    assert_decode_error do
      secret = OpenSSL::PKey::RSA.generate(2048)
      jwt = raw_encode(@encode_payload, secret, 'RS256')
      JwtManager.decode(jwt)
    end
  end

  test 'does not allow "none" algorithm' do
    assert_decode_error do
      jwt = raw_encode(@encode_payload, JwtManager::HMAC_SECRET, 'none')
      JwtManager.decode(jwt)
    end
  end

  private

  def assert_decode_error
    assert_raises JWT::DecodeError do
      yield
    end
  end

  # Use the jwt gem to encode
  def raw_encode(*args)
    JWT.encode(*args)
  end
end
