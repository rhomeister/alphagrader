# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| Faker::Internet.safe_email format('User %d', n) }
end

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email
    password { '12345678' }
    password_confirmation { password }
    confirmed_at { Time.zone.now if User.devise_modules.include?(:confirmable) }
  end
end
