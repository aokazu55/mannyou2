Rails.application.routes.draw do

  root to: 'sessions#new'
  # root 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions
  
end
