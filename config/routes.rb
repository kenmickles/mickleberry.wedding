Rails.application.routes.draw do
  root 'pages#home'
  
  resources :photos, only: [:index]
  resources :recommendations, only: [:index]
  
  # rsvps
  resources :rsvps, only: [:create, :update]
  get 'rsvp', to: 'rsvps#new', as: :new_rsvp
  get 'rsvp/guest', to: 'rsvps#guest'
  get 'rsvp/meal', to: 'rsvps#meal'
  get 'rsvp/message', to: 'rsvps#message'
  get 'rsvp/thanks', to: 'rsvps#thanks'
  get 'rsvp/sorry', to: 'rsvps#sorry'

  # pages
  get 'venue', to: 'pages#venue'
  get 'hotels', to: 'pages#hotels'

  # redirects
  get 'registry', to: redirect('https://www.amazon.com/registry/wedding/1XEYPJ43GL6AE')
end
