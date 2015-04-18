class ItemsController < ApplicationController
    
  def index
    sorts = choose_sort
    @sort_by , @sort_type = sorts[0] , sorts[1]
    set_session_sorting(@sort_by, @sort_type)
    @items = Item.all
    @items = order_items(@sort_by, @sort_type, @items)
    @all_status = Item.all_status
    if session[:cart] == {} then session[:cart] = nil end
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
      # errors = @item.errors.full_messages.join("<br>").html_safe
      errors = @item.errors.full_messages.join(". ")
      flash[:warning] = errors
    end
    redirect_to items_path
  end

  def checkout
    puts params
    # cart = params[:hash]
    redirect_to transactions_path(cart: cart)
  end

  def add_item
    puts "add item"
    cart = session[:cart] || Cart.new
    cart.add_item(params[:id])
    @cart_items = cart.cart_items
    @cart_total = cart.total
    respond_to do |format|
      format.js {}
    end
    session[:cart] = cart
  end

  def find
    if params[:phrase].blank?
      @items = Item.all
    else
      @items = Item.search(params[:phrase],fields: [{name: :word_start}], misspelling: {edit_distance: 2} , operator: "or").results
    end
    order_items(session[:sort_by],session[:sort_type], @items)
    @all_status = Item.all_status
    @sort_by = session[:sort_by]
    respond_to do |format|
      format.js{}
    end
  end

    def query
    # Get the search terms from the q parameter and do a search
    # as we seen in the previous part of the article.
    search =Item.search(params[:q],fields: [{name: :word_start}], misspelling: {edit_distance: 2} , operator: "or")
    puts(search)
    puts("fuuuuuuuuck")
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

  def should_sort?(sort_by)
    puts("should sort:#{sort_by} #{params}#{params.has_key?(sort_by)}")
    params.has_key?(:sort_by)
  end

  def sorted_before?(sort_by)
    session.has_key?(:sort_by)
  end
  ## sorting logic
  def choose_sort
    sort_by = params[:sort_by]
    puts(sort_by)
    if should_sort?(sort_by)
      # accounts for first time sorting in current session
      if !sorted_before?(sort_by)
        sort_type = 'ascending'
      # accounts for clicking an already sorted column to change the sort type (ascending <=> descending)  
      elsif sorted_before?(sort_by) && (params[:sort_by] == session[:sort_by])
        session[:sort_type] == 'ascending' ? (sort_type = 'descending') : (sort_type = 'ascending')
      # accounts for having sorted one column and now sorting a different column
      elsif sorted_before && (params[:sort_by] != session[:sort_by])
        sort_type = 'ascending'
      end
      puts("choose: #{sort_by}#{sort_type}")
      return [sort_by , sort_type]
    end
    return [nil , nil]
  end

  def order_items(sort_by, sort_type ,items)
    puts(items)
    Item.sort(sort_by, sort_type, items)
  end

  def set_session_sorting(sort_by, sort_type)
    session[:sort_by] = sort_by
    session[:sort_type] = sort_type
    puts('called')
  end
end
