# frozen_string_literal: true

module API
  module V1
    module Concerns
      # This module has helper functions with common render patterns
      module CommonRenders
        def render_unauthorized(error = 'Not Authorized')
          render json: { error: error }, status: :unauthorized
        end

        def render_bad_request(error)
          render json: { error: error }, status: :bad_request
        end
      end
    end
  end
end
