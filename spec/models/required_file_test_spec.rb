# frozen_string_literal: true
require 'rails_helper'

describe RequiredFileTest, type: :model do
  context 'run' do
    before { Sidekiq::Testing.fake! }

    it 'returns success if the file is present' do
      submission = create(:submission)
      File.open(submission.tempdir + '/report.pdf', 'w') do |file|
        file.write('report')
      end
      test = create(:required_file_test, filename: 'report.pdf')
      result = test.run(submission)

      expect(result).to be_success
    end

    it 'returns failure if the file is not present' do
      submission = create(:submission)
      test = create(:required_file_test, filename: 'report.pdf')
      result = test.run(submission)

      expect(result).to be_failure
    end
  end
end
