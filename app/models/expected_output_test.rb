class ExpectedOutputTest < Test
  validates :expected_program_output, presence: true
  validates :program_input, presence: true

  def run(directory)
    runner = TestRunner.new(directory, program_input, expected_program_output)
    runner.run
    ExpectedOutputTestResult.new(status: runner.status,
                   result_log: runner.result_log)
  end

  class TestRunner
    attr_accessor :directory, :output, :exit_code, :program_input, :expected_program_output
    def initialize(directory, program_input, expected_program_output)
      @directory = directory
      @program_input = program_input
      @expected_program_output = expected_program_output
    end

    def run
      Dir.chdir(directory) do
        @output = %x[echo '#{program_input}' | ./run 2>&1]
        @exit_code = $?.exitstatus
      end
    end

    def result_log
      output
    end

    def status
      return :error unless exit_code == 0
      return :failure unless correct_output?
      :success
    end

    def correct_output?
      clean_string(expected_program_output) == clean_string(output)
    end

    private

    def clean_string(string)
      string.split('\n').map(&:strip).reject(&:blank?).join('\n')
    end
  end
end
