class ItemsController < ApplicationController
    
    def find
    end
    
    def index

      if params.has_key?(:sort_type)
        @sort_type = params[:sort_type]
        session[:sort_type] = params[:sort_type]
      elsif session.has_key?(:sort_type)
        @sort_type = session[:sort_type]
      else
        @sort_type = nil
      end

      if params.has_key?(:sort_by) && session.has_key?(:sort_by) && (params[:sort_by] == session[:sort_by])
        new_sort = false
        @sort_type == 'ascending' ? (@sort_type = 'descending') : (@sort_type = 'ascending')
      # accounts for case of having sorted one column to sorting a different column
      elsif params.has_key?(:sort_by) && session.has_key?(:sort_by) && (params[:sort_by] != session[:sort_by])
        new_sort = true
        @sort_type = 'ascending'
      elsif params.has_key?(:sort_by) && !session.has_key?(:sort_by)
        new_sort = true
        @sort_type = 'ascending'
      else
        new_sort = false
        @sort_type = 'ascending'
      end

      if params.has_key?(:sort_by)
        @sort_by = params[:sort_by]
        should_sort = true
        session[:sort_by] = params[:sort_by]
      elsif session.has_key?(:sort_by)
        @sort_by = session[:sort_by]
        should_sort = false
      else
        @sort_by = nil
        should_sort = false
      end

      if should_sort 
        @items = Item.sort(@sort_by, @sort_type, new_sort)
      else
        @items = Item.all
      end

      @all_status = Item.all_status

      session[:cart] = session[:cart] || Hash.new
      @cart = []
      unless session[:cart].empty?
        #puts session[:cart]
        session[:cart].each do |id, quantity|
          item = Item.find(id)
          @cart << {name: item.name, quantity: quantity}
        end
      end
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
       cart = params[:hash]
       puts cart
       # # user_id = params[:user] 
       # total = 0.0
       # for item in items
       #      # Call appropriate transaction function
       # end
       # flash[:notice] = "Successful transaction"
       redirect_to transactions_path(cart: cart)
    end

    def add_item
      @cart = session[:cart]
      @id = params[:id]
      if @cart.has_key? @id
        @cart[@id] += 1
      else
        @cart[@id] = 1
      end
      session[:cart] = @cart
      redirect_to items_path
    end
end
