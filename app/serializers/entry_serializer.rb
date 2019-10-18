# frozen_string_literal: true

class EntrySerializer < ActiveModel::Serializer
  attributes :id, :day, :body
end
