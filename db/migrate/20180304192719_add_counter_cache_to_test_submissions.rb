# frozen_string_literal: true

class AddCounterCacheToTestSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :test_results_count, :integer, default: 0

    Submission.reset_column_information
    Submission.find_each do |p|
      Submission.reset_counters p.id, :test_results
    end
  end
end
