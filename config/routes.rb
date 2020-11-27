Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: %i[index new create show] do
    post "/vote", to: "votes#vote"
  end
  resources :users, only: %i[show]
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"
  delete "/logout", to: "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
