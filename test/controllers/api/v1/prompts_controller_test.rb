# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class PromptsControllerTest < ActionDispatch::IntegrationTest
      setup do
        token = generate_token(users(:one))
        @headers = jwt_cookie_header(token)
        @approved = prompts(:wordbank_fiction)
        @removed = prompts(:spam)
        @approved2 = prompts(:user_two)
      end

      test 'requires authentication' do
        get api_v1_prompts_url
        assert_response :unauthorized
      end

      test 'can GET #index' do
        get api_v1_prompts_url, headers: @headers
        assert_response :success
      end

      test '#index does not contain removed prompts' do
        get api_v1_prompts_url, headers: @headers
        actual = JSON.parse(response.body)
        returned_prompt_ids = actual.map { |prompt| prompt['id'] }

        assert_includes returned_prompt_ids, @approved.id
        assert_not_includes returned_prompt_ids, @removed.id
      end

      test 'can GET #show' do
        get "#{api_v1_prompts_url}/#{@approved.id}", headers: @headers
        assert_response :success
      end

      test "can GET #show for another user's prompt" do
        get "#{api_v1_prompts_url}/#{@approved2.id}", headers: @headers
        assert_response :success
      end

      test 'cannot GET #show a public removed prompt' do
        get "#{api_v1_prompts_url}/#{@removed.id}", headers: @headers
        assert_response :not_found
      end

      test 'can POST #create' do
        post api_v1_prompts_url, headers: @headers, params: { body: 'testing' }
        assert_response :created
      end

      test 'can DELETE #destroy' do
        delete "#{api_v1_prompts_url}/#{@approved.id}", headers: @headers
        assert_response :success
      end

      test "cannot DELETE another user's prompt" do
        delete "#{api_v1_prompts_url}/#{@approved2.id}", headers: @headers
        assert_response :not_found
      end

      test 'returns model errors upon bad #create' do
        params = { body: @approved.body }
        post api_v1_prompts_url, headers: @headers, params: params
        assert_response :bad_request
      end

      test 'admin can approve' do
        token = generate_token(users(:admin))
        headers = jwt_cookie_header(token)
        put "#{api_v1_prompts_url}/#{@removed.id}/approve", headers: headers
        assert_response :no_content
      end

      test 'admin can remove' do
        token = generate_token(users(:admin))
        headers = jwt_cookie_header(token)
        put "#{api_v1_prompts_url}/#{@approved.id}/remove", headers: headers
        assert_response :no_content
      end

      test 'user cannot approve' do
        put "#{api_v1_prompts_url}/#{@removed.id}/approve", headers: @headers
        assert_response :unauthorized
      end

      test 'user cannot remove' do
        put "#{api_v1_prompts_url}/#{@approved.id}/remove", headers: @headers
        assert_response :unauthorized
      end
    end
  end
end
