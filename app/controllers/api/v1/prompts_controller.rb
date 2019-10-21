# frozen_string_literal: true

module API
  module V1
    # This is the v1 controller for the Prompt model
    class PromptsController < APIController
      include Concerns::AuthenticateRequest
      include Concerns::CommonRenders

      before_action :authenticate_request!
      before_action :authenticate_admin!, only: %i[approve remove]

      def index
        render json: Prompt.approved, each_serializer: PromptSerializer
      end

      def show
        prompt = Prompt.approved.find_by_id(prompt_id)
        return render_not_found('Prompt') if prompt.nil?

        render json: prompt, serializer: PromptSerializer, status: :ok
      end

      def update
        prompt = current_user.prompts.find_by_id(prompt_id)
        return render_not_found('Prompt') if prompt.nil?

        updated = prompt.update(prompt_params)
        return render_bad_request(prompt.errors) unless updated

        render json: prompt, serializer: PromptSerializer, status: :ok
      end

      def create
        prompt = current_user.prompts.new(prompt_params)
        return render_bad_request(prompt.errors) unless prompt.save

        render json: prompt, serializer: PromptSerializer, status: :created
      end

      # Allow user to delete own prompt
      # Eventually replace with a :deleted state
      def destroy
        prompt = current_user.prompts.find_by_id(prompt_id)
        return render_not_found('Prompt') if prompt.nil?

        destroyed = prompt.destroy
        return render_bad_request('Could not delete prompt') unless destroyed

        head :no_content
      end

      def approve
        transition_state(:approve)
      end

      def remove
        transition_state(:remove)
      end

      private

      def prompt_id
        params.require(:id)
      end

      def prompt_params
        params.permit(:body)
      end

      def transition_state(event)
        prompt = Prompt.find_by_id(prompt_id)
        return render_not_found('Prompt') if prompt.nil?

        successful = prompt.send(event)
        return render_bad_request("Could not #{event} prompt") unless successful

        head :no_content
      end
    end
  end
end
