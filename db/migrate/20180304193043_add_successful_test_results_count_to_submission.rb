# frozen_string_literal: true

class AddSuccessfulTestResultsCountToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :successful_test_results_count, :integer
  end
end
