# frozen_string_literal: true

require 'aasm'

# A public writing prompt
class Prompt < ApplicationRecord
  include AASM

  belongs_to :submitter, class_name: 'User'
  validates :body, presence: true, uniqueness: { case_sensitive: false }

  aasm do
    state :approved, initial: true
    state :removed

    event :approve do
      transitions from: :removed, to: :approved
    end

    event :remove do
      transitions from: :approved, to: :removed
    end
  end
end
