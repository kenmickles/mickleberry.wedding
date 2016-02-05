Rails.application.routes.draw do
  root 'application#welcome'

  namespace :api do
    resources :gifts, only: [:index]
    resources :photos, only: [:create, :index, :show, :destroy] do
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :recommendations, only: [:index, :show]
    resources :users, only: [:create, :update, :show]
  end
end
