Makerpass::Application.routes.draw do
<<<<<<< HEAD
=======
  resources :items
  resources :admins
  resources :transactions
  get "/find" , to: "items#find", as: 'find'
  get '/checkout', to: 'items#checkout', as: 'checkout'
  post '/add-to-cart', to: 'items#add_to_cart'
  post '/order', to 'transactions#order', as: 'order'

  get '/logout', to: 'application#logout', as: 'logout'

end
