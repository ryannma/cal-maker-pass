class ItemsController < ApplicationController
    def find

    end
    
    def index
        @items = Item.all
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
