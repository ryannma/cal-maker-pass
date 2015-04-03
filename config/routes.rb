Makerpass::Application.routes.draw do
  resources :items
  get "/find" , to: "items#find", as: 'find'
  post "/checkout" , to: "items#checkout", as: 'checkout'
  
  get "/logout", to: "application#logout", as: 'logout'
end