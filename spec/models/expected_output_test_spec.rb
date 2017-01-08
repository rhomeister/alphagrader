# frozen_string_literal: true
require 'rails_helper'

describe ExpectedOutputTest, type: :model do
  context 'run' do
    it 'returns success if the program runs and returns the correct output' do
      submission = create(:submission)
      FileUtils.cp('spec/fixtures/dummy_programs/adder', submission.tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(submission)

      expect(result).to be_success
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
      expect(result.result_log).to_not be_blank
    end
  end
end
