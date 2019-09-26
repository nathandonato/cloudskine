# frozen_string_literal: true

module API
  module V1
    module Concerns
      # This module has helper functions with common render patterns
      module CommonRenders
        def render_unauthorized
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end
    end
  end
end
