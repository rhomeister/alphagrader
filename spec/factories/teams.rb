# frozen_string_literal: true

FactoryGirl.define do
  factory :team do
    github_repository_name { "user_#{SecureRandom.hex}/repo" }
  end
end
