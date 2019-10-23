# frozen_string_literal: true

module API
  module V1
    # This is the v1 base controller
    class APIController < ::ApplicationController
      include ::ActionController::Cookies
    end
  end
end
