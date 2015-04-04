class ItemsController < ApplicationController
    def find

    end
    
    def index
        @items = Item.all
        @all_status = Item.all_status

        @cart = [
          {
            name: "Capacitor",
            quantity: 4
          },
          {
            name: "Resistor",
            quantity: 1
          },
          {
            name: "Transistor",
            quantity: 7
          },
          {
            name: "Arduino",
            quantity: 2
          }
        ]
    end

    def update
      @updated_data = params[:item]
      @item = Item.find(params[:id])
      @item.name = @updated_data[:name]
      @item.price = @updated_data[:price]
      @item.quantity = @updated_data[:quantity]
      @item.status = @updated_data[:status]
      @item.kind = @updated_data[:kind]
      @item.save!
      redirect_to item_path
    end

    def delete
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to items_path
    end

    def show
      @item = Item.find(params[:id])
      @all_status = Item.all_status
    end

    def create
      @item = Item.new(params[:item])
      if @item.valid?
        @item.save
        flash[:notice] = "Successfully added item"
      else
        errors = @item.errors.full_messages.join("<br>").html_safe
        puts errors
        flash[:warning] = errors
      end
      redirect_to items_path
    end

    def checkout
       items = params[:cart]
       puts "items"
       puts items
       # # user_id = params[:user] 
       # total = 0.0
       # for item in items
       #      # Call appropriate transaction function
       # end
       # flash[:notice] = "Successful transaction"
       redirect_to items_path
    end

end
