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

      def create
        entry = current_user.entries.new(new_entry_params)
        return render_bad_request(entry.errors) unless entry.save

        render json: entry, serializer: EntrySerializer, status: :created
      end

      def destroy
        entry = current_user.entries.find_by_id(entry_id)
        return render_not_found('Entry') if entry.nil?

        return render_bad_request('Could not delete entry') unless entry.destroy

        head :no_content
      end

      private

      def entry_id
        params.require(:id)
      end

      def new_entry_params
        params.permit(:day, :body)
      end
    end
  end
end
