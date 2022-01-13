Rails.application.routes.draw do
  root to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, shallow: true
  end
  resources :likes, only: %i(create destroy)
end
