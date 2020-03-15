Rails.application.routes.draw do
  root 'sessions#new'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users

  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :sessions

  namespace :admin do
    resources :users
  end

  resources :labels
end
