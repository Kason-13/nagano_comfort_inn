NaganoComfortInn::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
end
