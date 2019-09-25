# frozen_string_literal: true

require 'test_helper'
require 'jwt_manager'

module API
  module V1
    # Create a fake controller to test APIController functionality
    class BaseController < APIController
      before_action :authenticate_request!

      def index
        render nothing: true
      end
    end

    # Note this test's name mismatches the file name. Needed for Rails' magic to
    # find the right controller class
    class BaseControllerTest < ActionDispatch::IntegrationTest
      setup do
        Rails.application.routes.draw { get 'base' => 'api/v1/base#index' }
        @user = users(:one)
        @jwt = JwtManager.encode(user_id: @user.id)
      end

      test 'autheticates user' do
        get '/base', headers: { 'Authorization' => @jwt }

        assert_response :success
        assert_equal @user, @controller.current_user
      end

      test 'renders unauthorized if no jwt provided' do
        get '/base'
        assert_response :unauthorized
      end

      test 'renders unauthorized if bad token' do
        jwt = JwtManager.encode(user_id: 0)
        get '/base', headers: { 'Authorization' => jwt }
        assert_response :unauthorized
      end
    end
  end
end
