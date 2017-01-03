# frozen_string_literal: true
class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description

      t.string :enrollment_code, unique: true
      t.timestamps
    end

    add_index :courses, :enrollment_code, unique: true
  end
end
