# frozen_string_literal: true

require 'test_helper'
require 'jwt_manager'

module API
  module V1
    module Concerns
      class NewAuthenticationTest < ActiveSupport::TestCase
        include NewAuthentication

        setup do
          @user = users(:one)
        end

        test 'creates cookie with proper value and options' do
          cookie_hash = create_jwt_cookie(@user.id)
          jwt = cookie_hash[:value]
          decoded_jwt = JwtManager.decode(jwt).first.with_indifferent_access

          assert_equal @user.id, decoded_jwt[:user_id]
          assert cookie_hash[:httponly]
          assert_equal decoded_jwt[:exp], cookie_hash[:expires].to_i
        end
      end
    end
  end
end
