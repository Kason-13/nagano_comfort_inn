NaganoComfortInn::Application.routes.draw do

  resources :rooms

  get "static_pages/home"
  get "static_pages/help"

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
end
