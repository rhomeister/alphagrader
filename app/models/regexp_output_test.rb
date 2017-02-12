# frozen_string_literal: true
class RegexpOutputTest < OutputTest
  def self.description
    [:regexp_output_test, {
      name: RegexpOutputTest.model_name.human,
      description: 'Checks whether the submitted program gives the correct '\
      'output for a specific input using a regular expression.',
      class: RegexpOutputTest
    }]
  end

  private

  def test_runner_class
    RegexpOutputTestRunner
  end
end
