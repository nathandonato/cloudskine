# frozen_string_literal: true

require 'test_helper'
require 'minitest/stub_any_instance'
require 'jwt_manager'

module API
  module V1
    module Concerns
      # Extending this module allows a controller to create new authentications
      class NewAuthenticationTest < ActiveSupport::TestCase
        extend NewAuthentication

        setup do
          @user = users(:one)
          @time = 1.week.from_now
        end

        test 'creates new jwt' do
          # Stub time to test expiration
          ActiveSupport::Duration.stub_any_instance(:from_now, @time) do
            jwt = self.class.create_jwt(@user)
            decoded = JwtManager.decode(jwt).first.with_indifferent_access

            assert_equal @user.id, decoded[:user_id]
            assert_equal @time.to_i, decoded[:exp]
          end
        end
      end
    end
  end
end
