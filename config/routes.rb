# frozen_string_literal: true
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

  resources :courses do
    resources :assignments
  end

  resources :assignments do
    resources :submissions
  end

  namespace :admin do
    # get "/stats" => "stats#stats"
    devise_scope :admin_user do
      get '/stats/:scope' => 'stats#stats', as: :admin_stats
    end
  end

  get 'setup' => 'setup#index'

  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
