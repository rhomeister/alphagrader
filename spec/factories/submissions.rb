# frozen_string_literal: true
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    uploaded_by { build(:user) }
  end
end
