# frozen_string_literal: true

require 'test_helper'
require 'jwt_manager'

class PromptSerializerTest < ActiveSupport::TestCase
  setup do
    @prompt = prompts(:wordbank_fiction)
  end

  test 'serializes prompt' do
    actual = PromptSerializer.new(@prompt).as_json

    assert_equal @prompt.id, actual[:id]
    assert_equal @prompt.body, actual[:body]
    assert_equal @prompt.submitter.username, actual[:submitter][:username]
  end
end
