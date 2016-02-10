Rails.application.routes.draw do
  root 'pages#home'

  namespace :api do
    resources :gifts, only: [:index]
    resources :photos, only: [:create, :index, :show, :destroy] do
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :recommendations, only: [:index, :show]
    resources :users, only: [:create, :update, :show]
  end

  resources :photos, only: [:index]
  resources :rsvps, only: [:create, :new]
  get 'rsvps/thanks', to: 'rsvps#thanks'
  get 'rsvps/sorry', to: 'rsvps#sorry'
  resources :recommendations, only: [:index]

  # pages
  get 'venue', to: 'pages#venue'
end
