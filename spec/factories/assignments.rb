# frozen_string_literal: true

FactoryBot.define do
  factory :assignment do
    name { SecureRandom.hex[0..10] }
    description { Faker::Lorem.paragraph }
    course
  end
end
