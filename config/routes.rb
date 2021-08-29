Rails.application.routes.draw do
  root 'pages#home'
  # get '/',to: "pages#home"
  
  get '/about', to: "pages#about"
  
  get '/signup', to: "users#new"
  # post '/users', to: "users#create"
  resources :users, except: [:new]

  resources :articles #, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

end
