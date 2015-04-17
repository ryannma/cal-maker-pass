class ItemsController < ApplicationController
    
  def index
    if params.has_key?(:sort)
      @sort = params[:sort]
      session[:sort] = params[:sort]
    elsif session.has_key?(:sort)
      @sort = session[:sort]
      need_redirect = true
    else
      @sort = nil
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
    session[:cart] = session[:cart] || Cart.new
    @cart = session[:cart]
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
        # Create an array from the search results.
        items = cart.results.map do |cart_item|
          # Each element will be a hash containing only the title of the article.
          # The title key is used by typeahead.js.
          { name: cart_item.name }
          { quantity: cart_item.quantity }
        end
        results = {
          items: items,
          total: cart.total
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
end