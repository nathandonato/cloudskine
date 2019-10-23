# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class EntriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        token = generate_token(users(:one))
        @headers = jwt_cookie_header(token)
      end

      test 'requires authentication' do
        get api_v1_entries_url
        assert_response :unauthorized
      end

      test 'can GET #index' do
        get api_v1_entries_url, headers: @headers
        assert_response :success
      end

      test 'can GET #show' do
        entry = entries(:hello_world)
        get "#{api_v1_entries_url}/#{entry.id}", headers: @headers
        assert_response :success
      end

      test 'cannot GET #show for another user' do
        entry = entries(:user_twos_first_entry)
        get "#{api_v1_entries_url}/#{entry.id}", headers: @headers
        assert_response :not_found
      end

      test 'can POST #create' do
        params = { day: Date.today, body: 'foobar' }
        post api_v1_entries_url, headers: @headers, params: params
        assert_response :created
      end

      test 'returns model errors upon bad #create' do
        params = { body: 'foobar' }
        post api_v1_entries_url, headers: @headers, params: params
        assert_response :bad_request
      end

      test 'can DELETE #destroy' do
        entry = entries(:hello_world)
        delete "#{api_v1_entries_url}/#{entry.id}", headers: @headers
        assert_response :no_content
      end

      test "cannot destroy another user's entry" do
        entry = entries(:user_twos_first_entry)
        delete "#{api_v1_entries_url}/#{entry.id}", headers: @headers
        assert_response :not_found
      end
    end
  end
end
