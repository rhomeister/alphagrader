# frozen_string_literal: true
class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.integer :status
      t.references :uploaded_by, foreign_key: { to_table: :users }
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
