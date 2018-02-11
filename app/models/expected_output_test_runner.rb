# frozen_string_literal: true

class ExpectedOutputTestRunner < OutputTestRunner
  def correct_output?
    clean_string(expected_program_output) == clean_string(output)
  end
end
