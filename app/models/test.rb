# frozen_string_literal: true
class Test < ApplicationRecord
  belongs_to :assignment
  has_many :test_results

  validates :name, presence: true

  VALID_TEST_TYPES =
    {
      expected_output_test: {
        name: ExpectedOutputTest.model_name.human,
        description: 'Checks whether the submitted program gives the correct output for a specific input.',
        class: ExpectedOutputTest
      },
      author_contribution_test: {
        name: AuthorContributionTest.model_name.human,
        description: 'Checks whether all team members have made a commit.',
        class: AuthorContributionTest
      }
    }.freeze
end
