# frozen_string_literal: true

require 'test_helper'
require 'jwt_manager'

module API
  module V1
    module Concerns
      # Extending this module allows a controller to create new authentications
      class NewAuthenticationTest < ActiveSupport::TestCase
        extend NewAuthentication

        setup do
          @user = users(:one)
        end

        test 'creates new jwt' do
          jwt = self.class.create_jwt(@user)
          decoded = JwtManager.decode(jwt).first.with_indifferent_access

          assert_equal @user.id, decoded[:user_id]
        end
      end
    end
  end
end
