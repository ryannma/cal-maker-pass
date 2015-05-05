Makerpass::Application.routes.draw do

  get "/transactions/balances", to: "transactions#balances", as: "balances"
  post "/items/find", to: "items#find", as: "find"
  #get "/items/find", to: "items#next_page", as: "next_page"
  resources :items, :transactions, :users

  # HOME
  root :to => "application#home"
  get "/logout", to: "application#logout", as: "logout"
  get "/signup", to: "users#new", as: "signup"

  # ITEM
  post "/items/:id/update", to: "items#update", as: "update_item"
  post "/items/:id/delete", to: "items#delete", as: "delete_item"
  post "/items/add_item", to: "items#add_item", as: "add_item"
  post "/items/delete_cart_item", to: "items#delete_cart_item", as: "delete_cart_item"
  post "/items/show_item", to: "items#show_item", as: "show_item"
  post "/items/create_item", to: "items#create_item", as: "create_item"
  post "/items/sort", to: "items#sort", as: "sort"
  #get "/items/inventory", to: "items#render_inventory", as: "render_inventory"
  # search engine
  get "/query", to: "items#query", as: "query"

  # TRANSACTION
  post "/transactions/new/:cart", to: "transactions#new", as: "new_transaction"
  post "/transactions/checkout", to: "transactions#checkout", as: "checkout"
  post "/transactions/sort", to: "transactions#sort", as: "trans_sort"

end