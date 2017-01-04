# frozen_string_literal: true
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    name { SecureRandom.hex[0..10] }
    description { Faker::Lorem.paragraph }
    course
  end
end
