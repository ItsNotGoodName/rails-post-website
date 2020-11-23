Rails.application.routes.draw do
  get 'users/new'
  root 'posts#index'
  resources :posts, only: [:index, :new, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
