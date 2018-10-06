# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    uploaded_by { build(:user) }
  end

  factory :file_submission, parent: :submission, class: 'FileSubmission' do
    file { File.new('spec/fixtures/dummy_submissions/correct.zip') }
  end
end
