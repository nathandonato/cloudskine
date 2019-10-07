# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class AuthenticationControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = User.create(username: 'foo', email: 'bar', password: 'baz')
        @user_params = { email: @user.email, password: @user.password }
      end

      teardown do
        User.destroy_all
      end

      test 'can log in' do
        post api_v1_login_path, params: { user: @user_params }
        body = JSON.parse(response.body)

        assert_response :success
        assert_equal @user.id, body['user']['id']
        assert_equal @user.id, JwtManager.decode(body['token']).first['user_id']
      end

      test 'returns unauthorized if incorrect password' do
        params = { user: @user_params.merge(password: 'wrong') }
        post api_v1_login_path, params: params
        error = JSON.parse(response.body)['error']

        assert_response :unauthorized
        assert_equal @controller.class::INVALID_LOGIN_MESSAGE, error
      end

      test 'returns unauthorized if unrecognized email' do
        User.destroy_all
        post api_v1_login_path, params: { user: @user_params }
        error = JSON.parse(response.body)['error']

        assert_response :unauthorized
        assert_equal @controller.class::INVALID_LOGIN_MESSAGE, error
      end
    end
  end
end
