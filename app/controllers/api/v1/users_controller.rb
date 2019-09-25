# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the User model
    class UsersController < APIController
      def create
        User.create(new_user_params)
      end

      private

      def new_user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end
