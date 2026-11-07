Rails.application.routes.draw do
  root "home#index"

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "dashboard", to: "dashboard#index"

  resources :activities do
    resources :reservations, only: [:create]
  end

  resources :reservations, only: [:index]
end