# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the User model
    class UsersController < APIController
      include Concerns::CommonRenders
      extend Concerns::NewAuthentication

      def create
        user = User.new(new_user_params)
        return render_bad_request(user.errors) unless user.save

        render json: self.class.authentication_payload(user), status: :created
      end

      private

      def new_user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end
