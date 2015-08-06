class ItemsController < ApplicationController
  respond_to :html, :json, :js

  def index
    @all_status = Item.all_status   
    clear_sort_session
    get_inv_params
    get_inv_items
    paginate_inv_items
    save_inv_params

    add_item # display cart
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
    flash[:notice] = @item.name + " successfully updated."
    render js: "window.location.href = '#{items_path}'"
  end

  def delete
    @item = Item.find(params[:id])
    name = @item.name
    @item.destroy
    flash[:notice] = name + " successfully deleted."
    render js: "window.location.href = '#{items_path}'"
  end

  def create_item
    @item = nil
    @mode = "create"
    @all_status = Item.all_status
  end

  def show_item
    @item = Item.find(params[:id])
    @all_status = Item.all_status
    @mode = "show"
  end

  def create
    @item = Item.new(params[:item])
    if @item.valid?
      @item.save
      flash[:notice] = @item.name + " successfully added."
    else
      # errors = @item.errors.full_messages.join("<br>").html_safe
      errors = @item.errors.full_messages.join(". ")
      flash[:warning] = errors
    end
    render js: "window.location.href = '#{items_path}'"
  end

  # cart actions
  def add_item
    cart = session[:cart] || Cart.new
    
    if params[:id]
      cart.add_item(params[:id])
    end
    
    @cart_items = cart.cart_items
    @cart_total = cart.total

    if params[:cart_sid] && !params[:cart_sid].empty?
      cart.sid = params[:cart_sid]
      @cart_sid = params[:cart_sid]
    elsif session[:cart]
      @cart_sid = session[:cart].sid
    else
      @cart_sid = ""
    end

    if params[:cart_purpose] && !params[:cart_purpose].empty?
      cart.purpose = params[:cart_purpose]
      @cart_purpose = params[:cart_purpose]
    elsif session[:cart]
      @cart_purpose = session[:cart].purpose
    else
      @cart_purpose = ""
    end

    session[:cart] = cart
  end

  def delete_cart_item
    cart = session[:cart] || return
    cart.delete_item(params[:id])
    @cart_items = cart.cart_items
    @cart_total = cart.total
    session[:cart] = cart
  end

  # triggered by twitter typeahead
  def query
    # Get the search terms from the q parameter and do a search
    # Generates the list of suggested search items below the search bar
    search = Item.search(params[:q],fields: [{name: :word_start}], misspelling: {edit_distance: 2} , operator: "or")
    respond_to do |format|
      format.json do
        # Create an array from the search results.
        results = search.results.map do |item|
          # Each element will be a hash containing only the title of the article.
          # The name key is used by typeahead.js.
          { name: item.name }
        end
        render json: results
      end
    end
  end

  # triggered on enter in search bar (queries db)
  def find
    clear_sort_session
    load
  end

  # triggered on click on column headers & pagination links
  def load
    update_inventory
  end

  def update_inventory
    @all_status = Item.all_status
    get_inv_params
    get_inv_items
    paginate_inv_items
    save_inv_params
    render "load"
  end

  private

  ## inventory @items loading logic

  def get_inv_params

    # get @phrase
    if should_find?
      @phrase = params[:phrase] || session[:phrase]
    else
      @phrase = nil
    end

    # get @sort_by and @sort_type
    if should_sort?
      @sort_by = params[:sort_by]
      @sort_type = get_sort_type
    elsif sorted_before?
      @sort_by, @sort_type = session[:sort_by], session[:sort_type]
    else
      @sort_by, @sort_type = nil, nil
    end

    # get @page
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end

  end

  def should_find?
    params.has_key?(:phrase) || session.has_key?(:phrase) 
  end

  def should_sort?
    params.has_key?(:sort_by)
  end

  def sorted_before?
    session.has_key?(:sort_by)
  end

  def get_sort_type
    if !sorted_before?
      # accounts for first time sorting in current session
      @sort_type = 'ascending'  
    elsif sorted_before? && (params[:sort_by] == session[:sort_by])
      # accounts for clicking an already sorted column to change the sort type (ascending <-> descending)
      session[:sort_type] == 'ascending' ? (@sort_type = 'descending') : (@sort_type = 'ascending')
    elsif sorted_before? && (params[:sort_by] != session[:sort_by])
      # accounts for having sorted one column and now sorting a different column
      @sort_type = 'ascending'
    end
  end

  # remember recent inventory conditions (search & sort)
  def save_inv_params
    session[:phrase] = @phrase
    session[:sort_by] = @sort_by
    session[:sort_type] = @sort_type
  end

  def clear_sort_session
    session[:phrase] = nil
    session[:sort_by] = nil
    session[:sort_type] = nil
  end

  # get @items
  def get_inv_items
    # according to search phrase
    get_searched_items
    # according to sorting params
    Item.sort(@items, @sort_by, @sort_type)
  end

  # searched by @phrase
  def get_searched_items
    if @phrase.blank?  
      @items = Item.all
    else
      @items = Item.search(@phrase, fields: [{name: :word_start}], misspelling: {edit_distance: 2}, operator: "or").to_ary
    end
  end

  def paginate_inv_items
    @items = Kaminari.paginate_array(@items).page(@page).per(15)
  end

end
