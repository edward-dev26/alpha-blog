Rails.application.routes.draw do
  root 'pages#home'

  get '/signup', to: 'users#new'
  resources :users, only: [:create, :edit, :update, :show, :index]

  resources :articles

  get '/about', to: 'pages#about'
end
