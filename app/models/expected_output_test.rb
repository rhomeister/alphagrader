# frozen_string_literal: true
class ExpectedOutputTest < OutputTest
  def self.description
    [:expected_output_test, {
      name: ExpectedOutputTest.model_name.human,
      description: 'Checks whether the submitted program gives the correct output for a specific input.',
      class: ExpectedOutputTest,
      help_page_url: 'https://github.com/rhomeister/alphagrader/wiki/Expected-Output-Test'
    }]
  end

  private

  def test_runner_class
    ExpectedOutputTestRunner
  end
end
