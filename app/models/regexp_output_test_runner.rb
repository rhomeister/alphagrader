# frozen_string_literal: true
class RegexpOutputTestRunner < OutputTestRunner
  def correct_output?
    regexp = Regexp.new expected_program_output
    regexp.match output
  end
end
