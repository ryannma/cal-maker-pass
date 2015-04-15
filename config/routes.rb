Makerpass::Application.routes.draw do
  resources :items
  resources :transactions

  # HOME
  root :to => "application#home"
  
  get "/find" , to: "items#find", as: "find"
  get "/logout", to: "application#logout", as: "logout"
  get "/signup", to: "users#new", as: "signup"

  #ITEM
  post "/items/:id/update", to: "items#update", as: "update_item"
  post "/items/:id/delete", to: "items#delete", as: "delete_item"
  post "/items/checkout/:hash", to: "items#checkout", as: "checkout"
  post "/items/add_item/:id", to: "items#add_item", as: "add_item"
  #search engine
  post "/items/find", to: "items#find", as: "find"
  get "/query", to: "items#query"

  #TRANSACTION
  post "/transactions/new/:cart", to: "transactions#new", as: "new_transaction"
end