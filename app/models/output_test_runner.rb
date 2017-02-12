class OutputTestRunner
  attr_accessor :directory, :output, :exit_code, :program_input, :expected_program_output
  def initialize(directory, program_input, expected_program_output)
    @directory = directory
    @program_input = program_input
    @expected_program_output = expected_program_output
  end

  def run
    Dir.chdir(directory) do
      @output = `echo '#{program_input}' | ./run 2>&1`
      @exit_code = $CHILD_STATUS.exitstatus
    end
  end

  def result_log
    output
  end

  def status
    return :error unless exit_code.zero?
    return :failure unless correct_output?
    :success
  end

  # needs to be overridden
  def correct_output?
    false
  end

  private

  def clean_string(string)
    string.split("\n").map(&:strip).reject(&:blank?).join("\n")
  end
end
