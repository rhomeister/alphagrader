class AddFieldsToTestResults < ActiveRecord::Migration[5.0]
  def change
    add_column :test_results, :name, :string
    add_column :test_results, :expected_program_output, :text
    add_column :test_results, :program_input, :text
    add_column :test_results, :public, :boolean
  end
end
