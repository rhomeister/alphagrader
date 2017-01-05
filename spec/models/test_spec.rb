# frozen_string_literal: true
require 'rails_helper'

describe Test, type: :model do
  it 'has test results' do
    test = create(:test)
    test_result = create(:test_result)
    test.test_results << test_result

    expect(test_result.reload.test).to eq test
    expect(test.reload.test_results).to eq [test_result]
  end

  context 'run' do
    it 'returns success if the program runs and returns the correct output' do
      tempdir = Dir.mktmpdir
      FileUtils.cp('spec/fixtures/dummy_programs/adder', tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(tempdir)

      expect(result).to be_success
    end

    it 'returns failure if the program gives wrong output' do
      tempdir = Dir.mktmpdir
      FileUtils.cp('spec/fixtures/dummy_programs/faulty_adder', tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(tempdir)

      expect(result).to be_failure
      expect(result.result_log).to_not be_blank
    end

    it 'returns error if the program fails to run' do
      tempdir = Dir.mktmpdir
      FileUtils.cp('spec/fixtures/dummy_programs/error', tempdir + '/run')
      test = create(:expected_output_test)
      result = test.run(tempdir)

      expect(result).to be_error
      expect(result.result_log).to_not be_blank
    end
  end
end
