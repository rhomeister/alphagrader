# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :assignment, foreign_key: true
      t.string :github_repository_name, index: true
      t.references :repository_owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
