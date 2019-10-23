# frozen_string_literal: true

namespace :development do
  desc 'Create a test user'
  task create_test_user: :environment do
    User.create!(username: 'admin',
                 email: 'user@foo.bar',
                 password: 'testing123',
                 user_type: 'admin')
  end
end
