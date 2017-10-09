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
    runfile = File.join(directory, 'run')
    return run_file_not_exists_error unless File.exist?(runfile)
    FileUtils.chmod 'u=wrx', runfile
    Timeout.timeout(TIME_LIMIT) do
      capture_output
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
    docker_options = '-i --read-only --sig-proxy --net=none --workdir=/submission --user=default'
    volume = "--volume=#{directory}:/submission"
    image = 'rhomeister/alphagrader'
    @output = `echo '#{program_input}' | docker run #{docker_options} #{volume} #{image} ./run 2>&1`
    @execution_time = Time.zone.now - start
    @exit_code = $CHILD_STATUS.exitstatus
    @errors << "Received non-zero exit code: #{@exit_code}" unless @exit_code.zero?
  end

  def clean_string(string)
    string = string.force_encoding('ISO-8859-2').encode!('UTF-8')
    string.split("\n").map(&:strip).reject(&:blank?).join("\n")
  end
end
