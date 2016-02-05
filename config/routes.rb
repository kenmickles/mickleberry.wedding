Rails.application.routes.draw do
  root 'application#welcome'

  namespace :api do
    resources :gifts, only: [:index]
    resources :photos, only: [:create, :index, :show]
    resources :recommendations, only: [:index, :show]
    resources :users, only: [:create, :update, :show]
  end
end
