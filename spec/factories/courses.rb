# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name { SecureRandom.hex }
    description { Faker::Lorem.paragraph }

    transient do
      instructor nil
      student nil
    end

    after(:create) do |course, evaluator|
      next unless evaluator.instructor

      course.memberships.create!(user: evaluator.instructor, role: :instructor)
    end

    after(:create) do |course, evaluator|
      next unless evaluator.student

      course.memberships.create!(user: evaluator.student)
    end
  end
end
