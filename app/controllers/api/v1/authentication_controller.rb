# frozen_string_literal: true

require 'memoist'

module API
  module V1
    # This is the v1 controller for the User model
    class AuthenticationController < APIController
      include Concerns::CommonRenders
      include Concerns::NewAuthentication
      extend Memoist

      INVALID_LOGIN_MESSAGE = 'Invalid email or password'

      def login
        return render_unauthorized(INVALID_LOGIN_MESSAGE) unless user.present?

        render_authentication_payload(user)
      end

      def logout
        cookies.delete(:jwt)
        head :no_content
      end

      private

      memoize def user
        User.find_by(email: login_params[:email])
          &.authenticate(login_params[:password])
      end

      def login_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
