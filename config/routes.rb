Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :users, only: [:new, :create]
  match '/signup', to: 'users#new', via: :get
  match '/signup', to: 'users#create', via: :post, as: :post_user

  resources :user_sessions, only: [:new, :create, :destroy]
  match '/login', to: 'user_sessions#new', via: :get
  match '/login', to: 'user_sessions#create', via: :post
  match '/logout', to: 'user_sessions#destroy', via: :get

  resources :tasks, only: [:new, :create, :update, :destroy] do
    post :change_state, on: :member
    post :upload_file, on: :member
  end
end
