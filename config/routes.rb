Rails.application.routes.draw do
  devise_for :users
  get 'likes/create'
  get 'comments/new'
  get 'comments/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
