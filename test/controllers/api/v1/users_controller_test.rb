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
          body = JSON.parse(response.body)
          user = body['user']
          token = body['token']

          assert_response :success
          refute_nil user['id']
          assert_equal user['id'], JwtManager.decode(token).first['user_id']
        end
      end

      test 'create requires :user param' do
        params = { foobar: @user_params }
        assert_raises ActionController::ParameterMissing do
          post api_v1_users_url, params: params, as: :json
        end
      end

      test 'create handles bad request' do
        assert_difference 'User.count', 0 do
          params = { user: @user_params.except(:username) }
          post api_v1_users_url, params: params, as: :json
          body = JSON.parse(response.body)

          assert_response :bad_request
          assert_includes body['error']['username'], "can't be blank"
        end
      end
    end
  end
end
