class CreateTestResults < ActiveRecord::Migration[5.0]
  def change
    create_table :test_results do |t|
      t.references :test, foreign_key: true
      t.references :submission, foreign_key: true
      t.integer :status
      t.text :result_log
      t.string :type

      t.timestamps
    end
  end
end
