# frozen_string_literal: true

class AddRunFileMissingBooleanToTestResult < ActiveRecord::Migration[5.0]
  def change
    add_column :test_results, :run_file_missing, :boolean, default: false
  end
end
