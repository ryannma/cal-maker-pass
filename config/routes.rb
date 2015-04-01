Makerpass::Application.routes.draw do
  get "sessions/create"

  get "sessions/destroy"

  resources :items
  get "/find" , to: "items#find", as: 'find'
  post "/checkout" , to: "items#checkout", as: 'checkout'
  
  get 'auth/:provider/callback', to: 'sessions#create' , as: 'login'
  get 'auth/failure', to: redirect('/items')
  get 'signout', to: 'sessions#destroy', as: 'signout'


end