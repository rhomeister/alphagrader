# frozen_string_literal: true
class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.references :course
      t.string :name
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
