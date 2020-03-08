Rails.application.routes.draw do
  # get 'sessions/new'
  root 'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end

  # root 'sessions#new'
  # root 'tasks#index'
  # resources :tasks
  # resources :users
  # resources :sessions

end
