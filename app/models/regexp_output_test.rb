# frozen_string_literal: true
class RegexpOutputTest < OutputTest
  def self.description
    [:regexp_output_test, {
      name: RegexpOutputTest.model_name.human,
      description: 'Checks whether the submitted program gives the correct '\
      'output for a specific input using a regular expression.',
      class: RegexpOutputTest,
      help_page_url: 'https://github.com/rhomeister/alphagrader/wiki/Expected-Output-Test'
    }]
  end

  def self.detailed_description
    "This test runs the following command: <code>./run < [input_file]</code>
     and compares the output of your program with a regular expression.
     <br>
     <br>
     Click to open a help page with more information."
  end

  private

  def test_runner_class
    RegexpOutputTestRunner
  end
end
