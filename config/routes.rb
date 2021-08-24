Rails.application.routes.draw do
  root 'pages#home'
  # get '/',to: "pages#home"
  get '/home', to: "pages#home"
  get '/about', to: "pages#about"
  resources :articles #, only: [:show, :index, :new, :create, :edit, :update, :delete]
end
