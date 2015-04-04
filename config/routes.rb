Makerpass::Application.routes.draw do
  resources :items
  resources :admins
  resources :transactions
  get "/find" , to: "items#find", as: 'find'
  post "/checkout" , to: "items#checkout", as: 'checkout'
  post "/admin/:id/lend", to: "admin#lend", as: 'lend'
  
  get "/logout", to: "application#logout", as: 'logout'
end