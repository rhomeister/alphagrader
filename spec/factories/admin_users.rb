# frozen_string_literal: true
FactoryGirl.define do
  factory :admin_user, class: 'User' do
    name { Faker::Name.name }
    email 'admin@example.com'
    password '12345678'
    password_confirmation '12345678'
    role :admin
    confirmed_at Time.zone.now
  end
end
