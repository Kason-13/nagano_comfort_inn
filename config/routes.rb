NaganoComfortInn::Application.routes.draw do

  resources :rooms

  get '/room_reservation/new/:id' => 'room_reservations#new'
  post '/room_reservation/new/:id' => 'room_reservations#create'
  get '/room_reservations' => 'room_reservations#index'

  resources :room_types, only: [:index,:new,:create,:destroy]
  resources :view_types, only: [:index,:new,:create,:destroy]

  get '/search' => 'rooms#search'

  get "static_pages/home"
  get "static_pages/help"

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  match '/admin', to: 'static_pages#admin'
  match '/logoff_admin', to: 'static_pages#exit_admin'
end
