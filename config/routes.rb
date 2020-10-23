NaganoComfortInn::Application.routes.draw do

  resources :rooms

  resources :room_types, only: [:index,:new,:create,:destroy]
  resources :view_types, only: [:index,:new,:create,:destroy]

  get "static_pages/home"
  get "static_pages/help"

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
end
