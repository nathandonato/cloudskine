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

  test 'must have user' do
    assert_not Entry.create(user: @user).valid?
  end

  test 'must have day' do
    assert_not Entry.create(day: Date.today).valid?
  end

  test 'is deleted with user' do
    @user.destroy!
    assert_raises { Entry.find(@entry.id) }
  end

  test 'scope #for_day' do
    day = Date.new(2019, 9, 19)
    assert_equal @entry, @user.entries.for_day(day)
  end

  test "does not find another user's entry" do
    user = users(:two)
    day = Date.new(1960, 1, 1)
    Entry.where(day: day).delete_all # clean up to assure clean assertion
    user.entries.create(day: day, body: 'foo')

    assert_nil @user.entries.for_day(day)
  end
end
