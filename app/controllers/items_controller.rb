class ItemsController < ApplicationController
    def find

    end
    
    def index
        @items = Item.all
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
      flash[:notice] = "Successfully added item"
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
