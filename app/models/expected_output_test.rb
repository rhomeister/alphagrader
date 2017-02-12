# frozen_string_literal: true
class ExpectedOutputTest < OutputTest
  def self.description
    [:expected_output_test, {
      name: ExpectedOutputTest.model_name.human,
      description: 'Checks whether the submitted program gives the correct output for a specific input.',
      class: ExpectedOutputTest
    }]
  end

  private

  def test_runner_class
    ExpectedOutputTestRunner
  end
end
