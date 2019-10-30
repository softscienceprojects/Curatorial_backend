Rails.application.routes.draw do
  get 'artwork_contents', to: "artwork_content#index"
  resources :contents
  resources :artworks
  resources :exhibitions
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
