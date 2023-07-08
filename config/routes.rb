Rails.application.routes.draw do
  devise_for :users
  get 'likes/create'
  get 'comments/new'
  get 'comments/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :create] do
          end
        end
      end
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
