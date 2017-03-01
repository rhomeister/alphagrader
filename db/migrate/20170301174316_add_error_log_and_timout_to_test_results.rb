# frozen_string_literal: true
class AddErrorLogAndTimoutToTestResults < ActiveRecord::Migration[5.0]
  def change
    add_column :test_results, :timeout, :boolean, default: false
    add_column :test_results, :error_log, :text
    add_column :test_results, :execution_time, :float
    add_column :test_results, :exit_code, :integer
  end
end
