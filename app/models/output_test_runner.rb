# frozen_string_literal: true
class OutputTestRunner
  TIME_LIMIT = 60

  attr_accessor :directory, :output, :exit_code, :program_input,
                :expected_program_output, :execution_time, :timeout

  def initialize(directory, program_input, expected_program_output)
    @directory = directory
    @program_input = program_input.gsub(/\r\n?/, "\n") # normalize line endings
    @expected_program_output = expected_program_output
    @errors = []
    @timeout = false
  end

  def run
    Dir.chdir(directory) do
      return run_file_not_exists_error unless File.exist?('run')
      FileUtils.chmod 'u=wrx', 'run'
      Timeout.timeout(TIME_LIMIT) do
        capture_output
      end
    end
  rescue Timeout::Error
    register_timeout_error
  end

  def result_log
    return '' if output.nil?
    output.encode('utf-8', invalid: :replace)
  end

  def error_log
    @errors.join("\n")
  end

  def run_file_not_exists_error
    @exit_code = 1
    @errors << 'File does not exist: run'
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

  def register_timeout_error
    @errors << "Execution time limit exceeded. Maximum execution time is #{TIME_LIMIT} seconds."
    @timeout = true
    @exit_code = 2
  end

  def capture_output
    start = Time.zone.now
    @output = `echo '#{program_input}' | ./run 2>&1`
    @execution_time = Time.zone.now - start
    @exit_code = $CHILD_STATUS.exitstatus
    @errors << "Received non-zero exit code: #{@exit_code}" unless @exit_code.zero?
  end

  def clean_string(string)
    string.split("\n").map(&:strip).reject(&:blank?).join("\n")
  end
end
