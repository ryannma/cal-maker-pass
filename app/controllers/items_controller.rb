class ItemsController < ApplicationController
    def find

    end
    
    def index
      @items = Item.all
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
      item = params[:item]
      # i = Item.new
      # item.each do |key, val|
      #   if val and val != "" 
      #     i.key = val
      #   end
      # end
      # i.create!
      Item.create!(item)
      flash[:notice] = "Successfully added item to database"
      redirect_to items_path
    end

    def show_cart
      #instantiate cart
      @cart = Hash.new
    end

    def add_to_cart
      #find items by dom elements and add them to the cart
      items = "instantiate me!"
      items.each do |item, quantity|
        if item in @cart
          @cart[item] += quantity
        else
          @cart[item] = quantity
        end
      end
      redirect_to items_path(:cart => @cart)
    end

    def checkout
      @cart = params[:cart]
      redirect_to transactions_path(:items => @cart)
    end

end
