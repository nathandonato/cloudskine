# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the Entry model
    class EntriesController < APIController
      include Concerns::AuthenticateRequest
      include Concerns::CommonRenders

      before_action :authenticate_request!

      def index
        render json: current_user.entries, each_serializer: EntrySerializer
      end

      def show
        entry = current_user.entries.find_by_id(entry_id)
        return render_not_found('Entry') if entry.nil?

        render json: entry, serializer: EntrySerializer, status: :ok
      end

      private

      def entry_id
        params.require(:id)
      end
    end
  end
end
