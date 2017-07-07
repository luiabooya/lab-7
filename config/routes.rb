BookManager2::Application.routes.draw do
  # Authentication routes
  get 'user/edit' => 'users#edit', :as => :edit_user
  get 'signup' => 'users#new', :as => :signup
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
  resources :sessions
  resources :users
  
  # Generated model routes
  resources :books
  resources :authors
  resources :categories
  
  # Additional routes
  get 'proposed' => 'books#proposed', as: :proposed_books
  get 'contracted' => 'books#contracted', as: :contracted_books
  
  # Set the root url
  root to: 'books#index'

end
