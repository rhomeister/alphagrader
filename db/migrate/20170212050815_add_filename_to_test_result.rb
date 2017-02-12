# frozen_string_literal: true
class AddFilenameToTestResult < ActiveRecord::Migration[5.0]
  def change
    add_column :test_results, :filename, :string
  end
end
