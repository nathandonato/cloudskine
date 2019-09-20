# frozen_string_literal: true

# A user with a secure password
class User < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
