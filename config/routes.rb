Rails.application.routes.draw do
  root 'pages#home'

  get '/signup', to: 'auth#signup'
  get '/login', to: 'auth#login'
  post '/login', to: 'auth#signin'
  delete '/logout', to: 'auth#logout'

  resources :users, only: [:create, :edit, :update, :show, :index]
  resources :articles

  get '/about', to: 'pages#about'
end
