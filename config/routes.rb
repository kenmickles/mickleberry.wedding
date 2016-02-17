Rails.application.routes.draw do
  root 'pages#home'

  namespace :api do
    resources :gifts, only: [:index]
    resources :photos, only: [:create, :index, :show, :destroy] do
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :recommendations, only: [:index, :show]
    resources :rsvps, only: [:create, :update, :show]
    resources :users, only: [:create, :update, :show]
  end

  resources :photos, only: [:index]
  
  resources :rsvps, only: [:create, :update]
  get 'rsvp', to: 'rsvps#new', as: :new_rsvp
  get 'rsvp/guest', to: 'rsvps#guest'
  get 'rsvp/meal', to: 'rsvps#meal'
  get 'rsvp/message', to: 'rsvps#message'
  get 'rsvp/thanks', to: 'rsvps#thanks'
  get 'rsvp/sorry', to: 'rsvps#sorry'

  resources :recommendations, only: [:index]

  # pages
  get 'venue', to: 'pages#venue'
end
