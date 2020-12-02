Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: %i[index new create show] do
    resources :comments, only: %i[create]
    post "/vote", to: "votes#vote"
  end
  resources :comments do
    post "/vote", to: "votes#vote"
  end
  resources :users, only: %i[create show] do
    resources :comments, only: %i[create]
  end
  resources :sessions, only: %i[create]
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  # Used for no javascript clients
  get "/logout", to: "sessions#destroy"
  delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
