# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the Entry model
    class EntriesController < APIController
      include Concerns::AuthenticateRequest

      before_action :authenticate_request!

      def index
        render json: current_user.entries, each_serializer: EntrySerializer
      end
    end
  end
end
