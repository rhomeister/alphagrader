# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    uploaded_by { build(:user) }
  end

  factory :file_submission, parent: :submission, class: 'FileSubmission' do
    file { File.new('spec/fixtures/dummy_submissions/correct.zip') }
  end
end
