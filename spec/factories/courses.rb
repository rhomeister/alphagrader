# frozen_string_literal: true
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name { SecureRandom.hex }
    description { Faker::Lorem.paragraph }
  end
end