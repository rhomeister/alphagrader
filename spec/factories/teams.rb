# frozen_string_literal: true
FactoryGirl.define do
  factory :team do
    github_repository_name { 'user/repo' }
  end
end
