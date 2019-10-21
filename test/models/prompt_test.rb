# frozen_string_literal: true

require 'test_helper'

class PromptTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @prompt = prompts(:wordbank_fiction)
  end

  test 'has attributes' do
    assert_equal @user, @prompt.submitter
    assert_match(/Write a scene/, @prompt.body)
  end

  test 'validates uniqueness of body' do
    duplicate = Prompt.new(submitter: @user, body: @prompt.body.upcase)
    assert_not duplicate.valid?
  end

  test 'has initial state' do
    prompt = Prompt.create(submitter: @user, body: 'foobar')
    assert prompt.approved?
  end

  test 'can remove a prompt' do
    @prompt.remove
    assert_not @prompt.approved?
    assert @prompt.removed?
  end
end
