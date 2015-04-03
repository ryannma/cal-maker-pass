class ItemsController < ApplicationController
    def find

    end
    
    def index
        @items = Item.all
        @all_status = Item.all_status
    end

    def show
      @item = Item.find(params[:id])
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
       items = params[:items]
       user_id = params[:user] 
       total = 0.0
       for item in items
            # Call appropriate transaction function
       end
       flash[:notice] = "Successful transaction"
       redirect items_path
    end

end