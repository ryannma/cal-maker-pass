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
      Item.create!(item)
      flash[:notice] = "Successfully added item to database"
      redirect_to items_path
    end

    def show_cart
      #instantiate cart
      @cart = Hash.new
    end

    def add_to_cart
      #do something here
      selected_items = "instantiate me!"

      selected_items.each do |item, quantity|
        
        #update database
        db_item = Item.find_by(name: item)
        new_db_quantity = db_item.quantity - quantity
        db_item.update(quantity: new_db_quantity)
        
        #update cart
        if @cart.members?(item)
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
