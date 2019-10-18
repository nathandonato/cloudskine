# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class EntriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        token = generate_token(users(:one))
        @headers = { 'Authorization' => token }
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
    end
  end
end
