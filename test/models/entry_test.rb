require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  setup do
    @entry = entries(:hello_world)
    @user = users(:one)
  end

  test 'can create' do
    Entry.delete_all
    assert_difference 'Entry.count', 1 do
      Entry.create(user: @user, day: Date.today)
    end
  end

  test 'returns body text' do
    assert_equal '**Hello World**', @entry.body
  end

  test 'must have day' do
    assert_not Entry.create(user: @user).valid?
  end

  test 'must have user' do
    assert_not Entry.create(day: Date.today).valid?
  end

  test 'is deleted with user' do
    @user.destroy!
    assert_raises { Entry.find(@entry.id) }
  end
end
