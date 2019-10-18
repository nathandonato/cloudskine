# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'
require 'jwt_manager'

module ActiveSupport
  class TestCase
    # Comment out this line if you are trying to use binding.pry
    # parallelize(workers: :number_of_processors)
    fixtures :all
  end
end

def generate_token(user = users(:one))
  JwtManager.encode(user_id: user.id)
end
