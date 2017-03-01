# frozen_string_literal: true
require 'rails_helper'

describe ExpectedOutputTest, type: :model do
  context 'run' do
    it 'returns success if the program runs and returns the correct output' do
      submission = create(:submission)
      FileUtils.cp('spec/fixtures/dummy_programs/adder', submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result.exit_code).to eq 0
      expect(result.timeout).to eq false
      expect(result.execution_time).to be > 0
      expect(result).to be_success
    end

    it 'still runs the program even if permissions are not set correctly' do
      submission = create(:submission)
      FileUtils.cp('spec/fixtures/dummy_programs/adder_wrong_permissions',
                   submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result).to be_success
    end

    it 'gives an error if the run script does not exist' do
      submission = create(:submission)
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result.error_log).to include 'File does not exist: run'
      expect(result).to be_error
    end

    it 'returns failure if the program takes too much time' do
      submission = create(:submission)
      # need to preload OutputTestRunner, otherwise stub_const will cause
      # problems
      expect(OutputTestRunner::TIME_LIMIT).to eq 60
      stub_const('OutputTestRunner::TIME_LIMIT', 0.01)

      FileUtils.cp('spec/fixtures/dummy_programs/sleeper', submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result).to be_error
      expect(result.error_log).to include 'Execution time limit exceeded'
      expect(result.timeout).to eq true
    end

    it 'returns failure if the program gives wrong output' do
      submission = create(:submission)
      FileUtils.cp('spec/fixtures/dummy_programs/faulty_adder', submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result).to be_failure
      expect(result.result_log).to_not be_blank
    end

    it 'returns error if the program fails to run' do
      submission = create(:submission)
      FileUtils.cp('spec/fixtures/dummy_programs/error', submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result).to be_error
      expect(result.error_log).to include 'Received non-zero exit code'
      expect(result.exit_code).to_not eq 0
      expect(result.result_log).to_not be_blank
    end
  end
end
