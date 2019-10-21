# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end

  test 'has attributes' do
    assert_equal 'User', @user.username
    assert_equal 'user@foo.bar', @user.email
  end

  test 'has secure password' do
    user = User.new(username: 'foo', email: 'bar', password: 'password')
    user.save
    user.reload

    assert_not_nil user.password_digest
  end

  test 'has user types' do
    assert @user.user?
    assert_not @user.admin?
    assert @admin.admin?
  end

  test 'enforces user type with rails validations' do
    opts = { username: 'foo', email: 'bar', password: '1', user_type: 'foo' }
    exception = assert_raises(ArgumentError) { User.new(opts) }

    assert_match(/is not a valid user_type/, exception.message)
  end
end
