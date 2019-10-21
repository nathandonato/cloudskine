# frozen_string_literal: true

class PromptSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :submitter, serializer: UserSerializer
end
