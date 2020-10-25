NaganoComfortInn::Application.routes.draw do

  resources :rooms, only: [:index,:show]
  get '/search' => 'rooms#search'

  namespace :admin do
    resources :room_types, only: [:index,:new,:create,:destroy]
    resources :view_types, only: [:index,:new,:create,:destroy]
    resources :rooms, only: [:new,:create,:destroy,:edit,:update]
    resources :price_modifiers
    resources :weekend_prices, only: [:edit,:update]
    get '/room_reservations' => 'room_reservations#index'
  end

  get '/room_reservation/new/:id' => 'room_reservations#new'
  post '/room_reservation/new/:id' => 'room_reservations#create'
  get '/my_reservations' => 'room_reservations#my_reservations'

  resources :clients, only: [:new, :create]

  resources :sessions, only: [:new,:create,:destroy]

  get "static_pages/home"
  get "static_pages/help"

  root to: 'static_pages#home'

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  match '/help', to: 'static_pages#help'

  match '/admin_mode', to: 'static_pages#admin'
  match '/logoff_admin', to: 'static_pages#exit_admin'
end
