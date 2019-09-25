# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

module ActiveSupport
  class TestCase
    # Comment out this line if you are trying to use binding.pry
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end
