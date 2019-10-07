# frozen_string_literal: true

require 'active_support/concern'
require 'jwt_manager'

module API
  module V1
    module Concerns
      # Extending this module allows a controller to create new authentications
      module NewAuthentication
        def authentication_payload(user)
          { user: UserSerializer.new(user), token: create_jwt(user) }
        end

        def create_jwt(user)
          return unless user&.valid?

          JwtManager.encode(user_id: user.id, exp: 1.week.from_now.to_i)
        end
      end
    end
  end
end
