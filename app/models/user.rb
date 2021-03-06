# frozen_string_literal: true

# A user with a secure password
class User < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :prompts, foreign_key: 'submitter_id', dependent: :nullify

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  enum user_type: { user: 'user', admin: 'admin' }
end
