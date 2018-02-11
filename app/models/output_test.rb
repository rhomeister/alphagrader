# frozen_string_literal: true

class OutputTest < Test
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
                                 exit_code: runner.exit_code,
                                 timeout: runner.timeout,
                                 execution_time: runner.execution_time,
                                 error_log: runner.error_log,
                                 result_log: runner.result_log,
                                 run_file_missing: runner.run_file_missing,
                                 public: public)
  end
end
