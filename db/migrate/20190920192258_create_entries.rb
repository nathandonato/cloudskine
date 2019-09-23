# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.text :body
      t.date :day, index: true, null: false
      t.timestamps
    end
  end
end
