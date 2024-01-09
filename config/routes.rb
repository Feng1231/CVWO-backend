# frozen_string_literal: true

Rails.application.routes.draw do
  patch :change_password, to: 'sign_up#change_password'
  patch :logout, to: 'sessions#destroy'
  get :logged_in, to: 'sessions#logged_in'

  resources :comment, only: %i[show create update destroy]
  resources :post, only: %i[show create update destroy] do
    member do
      patch :pin_post, to: 'posts#pin_post'
    end
  end
  resources :category, only: %i[index create update destroy] do
    collection do
      get '/all', to: 'forum#index_all'
      get '/:forum', to: 'forum#show_by_forum'
    end
  end

  resources :sign_up, only: %i[create], controller: 'sign_up'
  resources :log_in, only: %i[create], controller: 'sessions'
  resources :users, only: %i[index show] 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end