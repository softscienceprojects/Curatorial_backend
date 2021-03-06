Rails.application.routes.draw do
  resources :exhibition_likes, only: [:index, :create, :destroy]
  resources :artwork_exhibitions, only: [:index, :create, :destroy]
  get 'artwork_contents', to: "artwork_content#index"
  resources :contents, only: [:index]
  resources :artworks
  resources :exhibitions
  resources :users
  resources :relationships, only: [:create, :destroy]
  post '/signin', to: 'auth#create'
  post '/signup', to: 'users#create'
  post '/validate', to: 'auth#validate'
  get '/content_names', to: 'contents#names'
  get '/search', to: 'contents#search'
  get '/explore', to: 'artworks#explore'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
