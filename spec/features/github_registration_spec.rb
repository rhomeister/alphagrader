# frozen_string_literal: true

require 'rails_helper'

feature 'GithubAuthRegistration', type: :feature do
  include Warden::Test::Helpers

  let(:user_attributes) { attributes_for(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(:github, uid: '12345',
                                      info: {
                                        name: user_attributes[:name],
                                        email: user_attributes[:email]
                                      })
  end

  after do
    Warden.test_reset!
    Rails.application.env_config['omniauth.auth'] = nil
    ActionMailer::Base.deliveries.clear
  end

  it 'should create a new user' do
    visit user_github_omniauth_callback_path

    i = Identity.first
    expect(i.uid).to eq('12345')
    expect(i.name).to eq(user_attributes[:name])
    expect(i.email).to eq(user_attributes[:email])
    expect(i.user_id).to_not be_nil
    expect(i.user.name).to eq(user_attributes[:name])
    expect(i.user.email).to eq(user_attributes[:email])

    expect(page.body).to include('Successfully authenticated from Github account.')
    expect(ActionMailer::Base.deliveries).to be_empty
  end

  it 'should merge the identity if the user already exists' do
    u = create(:user)
    expect(ActionMailer::Base.deliveries).to be_empty
    login_as u, scope: :user

    expect(User.count).to eq(1)
    expect(Identity.count).to eq(0)

    visit user_github_omniauth_callback_path

    expect(User.count).to eq(1)
    expect(Identity.count).to eq(1)
    u = User.first
    expect(u.email).to_not eq(user_attributes[:email])

    expect(Identity.first.user_id).to eq(u.id)
    expect(ActionMailer::Base.deliveries).to be_empty
  end

  it 'should populate the email address if empty' do
    u = create(:oauth_user)
    login_as u, scope: :user

    expect(User.count).to eq(1)
    expect(User.first.email).to_not eq(user_attributes[:email])
    expect(Identity.count).to eq(0)

    visit user_github_omniauth_callback_path

    expect(User.count).to eq(1)
    expect(Identity.count).to eq(1)
    u = User.first
    expect(u.name).to eq(user_attributes[:name])
    expect(u.email).to eq(user_attributes[:email])
    expect(ActionMailer::Base.deliveries).to be_empty

    expect(Identity.first.user_id).to eq(u.id)
  end
end
