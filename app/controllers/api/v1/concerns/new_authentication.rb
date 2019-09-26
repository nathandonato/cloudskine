# frozen_string_literal: true

require 'active_support/concern'
require 'jwt_manager'

module API
  module V1
    module Concerns
      # Extending this module allows a controller to create new authentications
      module NewAuthentication
        def create_jwt(user)
          return unless user&.valid?

          JwtManager.encode(user_id: user.id)
        end
      end
    end
  end
end
