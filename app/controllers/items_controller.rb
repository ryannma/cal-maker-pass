class ItemsController < ApplicationController
    
  def index
    @items = ordering()
    @all_status = Item.all_status
    #puts "before"
    session[:cart] = session[:cart] || Cart.new
    @cart = session[:cart]
    #puts @cart.cart_items
    #puts '*' * 54
    @display_cart = []
    unless @cart.cart_items.nil?
      @cart.cart_items.each do |cart_item|
        @display_cart << {name: cart_item.name, quantity: cart_item.quantity}
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
      flash[:warning] = errors
    end
    redirect_to items_path
  end

  def checkout
    cart = params[:hash]
    redirect_to transactions_path(cart: cart)
  end

  def add_item
    cart = session[:cart] || Cart.new
    cart.add_item(params[:id])
    respond_to do |format|
      format.json do
        Create an array from the search results.
        cart_items = cart.cart_items.map do |cart_item|
          { cart_item: cart_item }
        end
        results = {
          cart_items: cart.cart_items,
          cart_total: cart.total
        }
        render json: results
      end
    end
    session[:cart] = cart
  end


  # def find
  #   puts "hereee"
  #   @items = Item.search{ keywords params[:phrase]}.results
  #   @all_status = Item.all_status
  #   session[:cart] = session[:cart] || Hash.new
  #   @cart = []
  #   @sort = nil
  #   unless session[:cart].empty?
  #     puts session[:cart]
  #     session[:cart].each do |id, quantity|
  #       item = Item.find(id)
  #       @cart << {name: item.name, quantity: quantity}
  #     end
  #   end
  #   render :index
  # end

  def query
    # Get the search terms from the q parameter and do a search
    # as we seen in the previous part of the article.
    search = Item.search{ keywords params[:q]}
    respond_to do |format|
      format.json do
        # Create an array from the search results.
        results = search.results.map do |item|
          # Each element will be a hash containing only the title of the article.
          # The title key is used by typeahead.js.
          { name: item.name }
        end
        render json: results
      end
    end
  end

  private

  ## sorting logic
  def ordering()
    params.has_key?(:sort_by) ? (should_sort = true) : (should_sort = false)
    session.has_key?(:sort_by) ? (sorted_before = true) : (sorted_before = false)
    if should_sort
      @sort_by = params[:sort_by]
      # accounts for first time sorting in current session
      if !sorted_before
        @sort_type = 'ascending'
      # accounts for clicking an already sorted column to change the sort type (ascending <=> descending)  
      elsif sorted_before && (params[:sort_by] == session[:sort_by])
        session[:sort_type] == 'ascending' ? (@sort_type = 'descending') : (@sort_type = 'ascending')
      # accounts for having sorted one column and now sorting a different column
      elsif sorted_before && (params[:sort_by] != session[:sort_by])
        @sort_type = 'ascending'
      end
      session[:sort_by] = @sort_by
      session[:sort_type] = @sort_type
      Item.sort(@sort_by, @sort_type)
    else
      Item.all
    end
  end

end
