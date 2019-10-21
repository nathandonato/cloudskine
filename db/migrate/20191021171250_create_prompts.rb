# frozen_string_literal: true

class CreatePrompts < ActiveRecord::Migration[6.0]
  def change
    create_table :prompts do |t|
      t.references :submitter, index: true, foreign_key: { to_table: :users }
      t.text :body, null: false
      t.string :aasm_state
      t.timestamps
    end
  end
end
