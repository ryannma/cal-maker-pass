class ItemsController < ApplicationController
    
  def index
    get_inv_params
    @items =  Item.order(@sort_by).page(params[:page]).per(20)
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
    save_inv_params
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
    render js: "window.location.href = '#{items_path}'"
  end

  def delete
    @item = Item.find(params[:id])
    @item.destroy
    render js: "window.location.href = '#{items_path}'"
  end

  def create_item
    # puts "hi"*1000
    @item = nil
    @mode = "create"
    @all_status = Item.all_status
    respond_to do |format|
      format.js {}
    end
  end

  def show_item
    # puts "hi"*1000
    @item = Item.find(params[:id])
    @all_status = Item.all_status
    @mode = "show"
    puts @item
    respond_to do |format|
      format.js {}
    end
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
    render js: "window.location.href = '#{items_path}'"
  end

  def add_item
    cart = session[:cart] || Cart.new
    cart.add_item(params[:id])
    @cart_items = cart.cart_items
    @cart_total = cart.total
    respond_to do |format|
      format.js {}
    end
    session[:cart] = cart
  end

  def delete_cart_item
    cart = session[:cart] || return
    cart.delete_item(params[:id])
    @cart_items = cart.cart_items
    @cart_total = cart.total
    respond_to do |format|
      format.js {}
    end
    session[:cart] = cart
  end

  def find
    get_inv_params
    @all_status = Item.all_status
    if @phrase.blank?
       @items = Item.order("name").page(params[:page]).per(20)
    else
      @items= Item.search(@phrase, fields: [{name: :word_start}], misspelling: {edit_distance: 2}, operator: "or", per_page: 20, page: params[:page])
    end
    respond_to do |format|
      format.js{}
      format.html{render 'index'}
    end
    save_inv_params
  end

  def next_page
    get_inv_params
    @phrase.blank? ? @items = Item.order("name").page(params[:page]).per(20) : @items = Item.search(@phrase, fields: [{name: :word_start}], misspelling: {edit_distance: 2}, operator: "or", per_page: 20, page: params[:page])
    Item.sort(@items, @sort_by, @sort_type)
    render 'find'
    save_inv_params
  end

  def query
    # Get the search terms from the q parameter and do a search
    # as we seen in the previous part of the article.
    search = Item.search(params[:q],fields: [{name: :word_start}], misspelling: {edit_distance: 2} , operator: "or")
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

  def sort
    get_inv_params
    @all_status = Item.all_status
    @phrase.blank? ? (@items = Item.all) : (@items = Item.search(@phrase, fields: [{name: :word_start}], misspelling: {edit_distance: 2}, operator: "or").results)
    Item.sort(@items, @sort_by, @sort_type)
    respond_to do |format|
      format.js{}
    end
    save_inv_params
  end

  private

  ## sorting logic

  def should_find?
    params.has_key?(:phrase) # || (session.has_key?(:phrase) && !session[:phrase].nil?) 
  end

  def should_sort?
    params.has_key?(:sort_by)
  end

  def sorted_before?
    session.has_key?(:sort_by) && !session[:sort_by].nil?
  end

  # gets @sort_by, @sort_type, and @phrase
  def get_inv_params
    if should_sort?
      @sort_by = params[:sort_by]
      # accounts for first time sorting in current session
      if !sorted_before?
        @sort_type = 'ascending'
      # accounts for clicking an already sorted column to change the sort type (ascending <-> descending)  
      elsif sorted_before? && (params[:sort_by] == session[:sort_by])
        session[:sort_type] == 'ascending' ? (@sort_type = 'descending') : (@sort_type = 'ascending')
      # accounts for having sorted one column and now sorting a different column
      elsif sorted_before? && (params[:sort_by] != session[:sort_by])
        @sort_type = 'ascending'
      end
    elsif sorted_before?
      @sort_by, @sort_type = session[:sort_by], session[:sort_type]
      # only store state of previous request
      #session[:sort_by], session[:sort_type] = nil, nil
    else
      @sort_by, @sort_type = nil, nil
    end
    # if should_find?
    #   params.has_key?(:phrase) ? (@phrase = params[:phrase]) : (@phrase = session[:phrase])
    # else
    #   @phrase = nil
    # end
    @phrase = params[:phrase]
  end

  # remember recent inventory conditions (filter & order)
  def save_inv_params
    # session[:phrase] = @phrase
    session[:sort_by] = @sort_by
    session[:sort_type] = @sort_type
  end

end
