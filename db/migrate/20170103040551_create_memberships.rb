# frozen_string_literal: true
class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true

      t.integer :role

      t.timestamps
    end
  end
end
