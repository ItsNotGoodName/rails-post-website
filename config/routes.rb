Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: %i[index new create show] do
    resources :comments, only: %i[create]
    post "/vote", to: "votes#vote"
  end
  resources :comments do
    post "/vote", to: "votes#vote"
  end
  resources :users, only: %i[create show]
  get "/register", to: "users#new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"
  delete "/logout", to: "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
