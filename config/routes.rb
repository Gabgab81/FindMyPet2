Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :adverts do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:edit, :update, :destroy]

  resources :users, only: [:show] do
    member do
      get :user_adverts
    end
  end

end
