# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the User model
    class UsersController < APIController
      include Concerns::CommonRenders
      include Concerns::NewAuthentication

      def create
        user = User.new(new_user_params)
        return render_bad_request(user.errors) unless user.save

        render_authentication_payload(user)
      end

      private

      def new_user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end
