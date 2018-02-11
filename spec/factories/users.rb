# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| Faker::Internet.safe_email format('User %d', n) }
end

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email
    password '12345678'
    password_confirmation { password }
    confirmed_at Time.zone.now if User.devise_modules.include?(:confirmable)
  end
end
