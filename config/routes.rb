Rails.application.routes.draw do

  # root 'sessions#new'
  root 'tasks#index'
  resources :tasks
  resources :users
  # resources :sessions

end
