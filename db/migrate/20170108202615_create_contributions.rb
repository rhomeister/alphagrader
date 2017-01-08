# frozen_string_literal: true
class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.references :membership, foreign_key: true
      t.references :submission, foreign_key: true

      t.timestamps
    end
  end
end
