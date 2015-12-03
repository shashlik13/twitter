Rails.application.routes.draw do

 root "static_pages#home"
 match "/about", to: "static_pages#about", via: :get
 match "/shop", to: "static_pages#shop", via: :get
 get "/signup", to: "users#new"
 get "/signin", to: "sessions#new"
 match "/signout", to: "sessions#destroy", via: :delete
 
 resources :users
 resources :sessions, only: [:new, :create, :destroy]
 
 
end
