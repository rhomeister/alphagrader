# frozen_string_literal: true
require 'resque_web'
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    omniauth_callbacks: 'omniauth_callbacks' }

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  authenticated do
    devise_scope :user do
      root to: 'courses#index'
    end
  end

  resource :github_webhooks, only: :create, defaults: { formats: :json }

  resources :courses do
    resources :assignments
  end

  resources :assignments do
    resources :submissions
    resources :tests
    resources :teams
  end

  resources :enrollments

  namespace :admin do
    # get "/stats" => "stats#stats"
    devise_scope :admin_user do
      get '/stats/:scope' => 'stats#stats', as: :admin_stats
    end
  end

  get 'setup' => 'setup#index'

  ActiveAdmin.routes(self)

  resque_web_constraint = lambda do |request|
    if Rails.env.development?
      true
    else
      current_user = request.env['warden'].user
      current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?
    end
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine, at: '/resque'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
end
