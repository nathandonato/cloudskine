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
        jwt = JwtManager.decode(response.cookies['jwt'])

        assert_response :success
        assert_equal @user.id, body['user']['id']
        assert_equal @user.id, jwt.first['user_id']
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

      # TODO: Figure out a way to actually test that the cookie gets deleted.
      test 'can log out' do
        delete api_v1_logout_path

        assert_response :success
      end
    end
  end
end
