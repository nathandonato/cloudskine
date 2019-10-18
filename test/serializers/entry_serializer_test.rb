# frozen_string_literal: true

require 'test_helper'

class EntrySerializerTest < ActiveSupport::TestCase
  setup do
    @entry = entries(:hello_world)
  end

  test 'serializes entry' do
    actual = EntrySerializer.new(@entry).as_json

    assert_equal @entry.id, actual[:id]
    assert_equal @entry.day, actual[:day]
    assert_equal @entry.body, actual[:body]
  end
end
