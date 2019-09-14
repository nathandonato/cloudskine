# frozen_string_literal: true

namespace :development do
  desc 'Create a test user'
  task create_test_user: :environment do
    User.create!(username: 'admin',
                 email: 'nathanjdonato+dev@gmail.com',
                 password: 'testing123')
  end
end
