class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.references :assignment, foreign_key: true

      t.string :name
      t.text :description
      t.string :type
      t.text :program_input
      t.text :expected_program_output
      t.boolean :public

      t.timestamps
    end
  end
end
