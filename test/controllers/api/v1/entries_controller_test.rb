# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class EntriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @token = generate_token
      end

      test 'requires authentication' do
        get api_v1_entries_url
        assert_response :unauthorized
      end

      test 'can GET #index' do
        get api_v1_entries_url, headers: { 'Authorization' => @token }
        assert_response :success
      end
    end
  end
end
