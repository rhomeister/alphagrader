# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_user, class: 'User' do
    before(:create) do |user, _evaluator|
      user.oauth_callback = true
    end
    confirmed_at { Time.zone.now if User.devise_modules.include? :confirmable }
  end
end
