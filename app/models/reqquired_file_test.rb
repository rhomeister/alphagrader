# frozen_string_literal: true
class RequiredFileTest < Test
  validates :expected_program_output, presence: true
  validates :program_input, presence: true

  def run(submission)
    directory = submission.tempdir
    runner = test_runner_class.new(directory, program_input, expected_program_output)
    runner.run
    ExpectedOutputTestResult.new(status: runner.status,
                                 name: name,
                                 expected_program_output: expected_program_output,
                                 program_input: program_input,
                                 result_log: runner.result_log,
                                 public: public)
  end
end
