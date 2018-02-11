# frozen_string_literal: true

require 'rails_helper'

describe Admin::StatsController, type: :controller do
  # before( :each ) do
  #   @request.env["devise.mapping"] = Devise.mappings[:admin_user]
  #   # @request.env["warden"] ||= Whatever.new
  # end

  it 'should require the scope param' do
    sign_in create(:admin_user)

    get :stats, params: { scope: '' }
    expect(response.status).to eq(422)
    expect(response.content_type).to eq('application/json')
    expect(response.body).to eq('{"errors":"scope not set"}')
  end

  it 'should return data for a logged in user' do
    sign_in create(:admin_user)

    get :stats, params: { scope: 'user' }
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
  end
end
