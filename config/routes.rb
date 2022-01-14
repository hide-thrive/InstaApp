Rails.application.routes.draw do
  root to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, shallow: true
    get :search, on: :collection
  end
  resources :likes, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)

  namespace :mypage do
    resource :account, only: %i(edit update)
  end
end
