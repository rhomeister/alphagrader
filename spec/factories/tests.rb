# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test do
    name { SecureRandom.hex[0..10] }
    description { Faker::Lorem.paragraph }
    assignment
  end

  factory :expected_output_test, parent: :test, class: 'ExpectedOutputTest' do
    # test for a program that adds numbers
    program_input { "1 1\n1 2" }
    expected_program_output { "2\n3" }
  end

  factory :regexp_output_test, parent: :test, class: 'RegexpOutputTest' do
    # test for a program that adds numbers
    program_input { "1 1\n1 2" }
    expected_program_output { ".*\n2\n3$.*" }
  end

  factory :author_contribution_test, parent: :test, class: 'AuthorContributionTest' do
  end

  factory :required_file_test, parent: :test, class: 'RequiredFileTest' do
    filename 'test'
  end
end
