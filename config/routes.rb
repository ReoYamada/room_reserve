Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
resources :rooms
resources :users
resources :reserves

get "/" => "home#top"

get "login" => "users#login_form"
post "login" => "users#login"
post "logout" => "users#logout"

get "search" => "rooms#search"
end
