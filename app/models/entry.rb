# frozen_string_literal: true

# A journal entry for a given day, belonging to a user
class Entry < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :day
  validates_uniqueness_of :day, scope: :user_id

  def self.for_day(day)
    find_by(day: day)
  end
end
