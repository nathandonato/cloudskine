# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_params = {
          username: 'me', email: 'foo@bar.com', password: 'foobar'
        }
      end

      test 'should create' do
        assert_difference 'User.count', 1 do
          params = { user: @user_params }
          post api_v1_users_url, params: params, as: :json
          assert_response :success
        end
      end

      test 'requires :user param' do
        params = { foobar: @user_params }
        assert_raises ActionController::ParameterMissing do
          post api_v1_users_url, params: params, as: :json
        end
      end

      test 'handles missing parameter' do
        skip 'Not yet supported'

        assert_difference 'User.count', 0 do
          params = { user: @user_params.except(:email) }
          post api_v1_users_url, params: params, as: :json
          assert_response :bad_request
        end
      end
    end
  end
end
