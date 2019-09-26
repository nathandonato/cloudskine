# frozen_string_literal: true

require 'test_helper'
require 'jwt_manager'

class UserSerializerTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'serializes user' do
    actual = UserSerializer.new(@user).as_json

    assert_equal @user.id, actual[:id]
    assert_equal @user.username, actual[:username]
    assert_equal @user.email, actual[:email]
    assert_nil actual[:password]
    assert_nil actual[:password_digest]
  end
end
