Rails.application.routes.draw do
  concern :voteable do
    post "/vote", to: "votes#vote"
  end
  concern :commentable do
    resources :comments, only: %i[create]
  end
  root "posts#index"
  resources :posts, concerns: [:commentable, :voteable]
  resources :comments, only: %i[create], concerns: :voteable
  resources :users, concerns: :commentable
  resources :sessions
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  # Used for no javascript clients
  get "/logout", to: "sessions#destroy"
  delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
