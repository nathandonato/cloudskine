# frozen_string_literal: true

class AddUserTypeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :user_type, :string, null: false, default: 'user')
  end
end
