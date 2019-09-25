# frozen_string_literal: true

require 'jwt_manager'
require 'memoist'

module API
  module V1
    # This is the v1 base controller
    class APIController < ::ApplicationController
      extend Memoist

      def authenticate_request!
        render_unauthorized unless current_user.present?
      end

      memoize def current_user
        return unless jwt_payload.present?

        user_id = jwt_payload.first['user_id']
        User.find_by_id(user_id)
      end

      private

      def render_unauthorized
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end

      # Attempt to decode the JWT if present; return nil if invalid
      memoize def jwt_payload
        return if jwt.blank?

        begin
          JwtManager.decode(jwt)
        rescue JWT::VerificationError, JWT::DecodeError
          return
        end
      end

      memoize def jwt
        request&.headers&.[]('Authorization')&.split(' ')&.last
      end
    end
  end
end
