class TransactionsController < ApplicationController
  respond_to :html, :json, :js

  def index
    clear_sort_session
    get_trans_params
    get_trans
    paginate_trans
    save_trans_params
  end

  # buyer, items, & purpose in params sent from cart.js
  def checkout
    # look up admin by uid found in cas FIGURE THIS OUT
    admin_user = User.where(uid: session[:cas_user])[0]
    admin = Admin.where(user_id: admin_user.id)[0]
    if admin.nil?
      admin = Admin.find(1)
    end

    # if user doesn't exist in system, return error
    buyer = User.where(sid: params[:buyer])[0]
    if buyer.nil?
      render :nothing => true, :status => :unauthorized
      return
    end

    # if requested item quantities aren't availible, return error.
    items = params[:items] # hash of index, [name, quantity]
    if !Item.quant_avail(items)
      render :nothing => true, :status => :bad_request
      return
    end
    # update items in db
    Item.update_quant(items)

    purpose = params[:purpose]

    # make transaction
    tx = Transaction.new(:purpose=>purpose);
    tx.user = buyer
    tx.admin = admin
    tx.save
    item_array = []
    index = 0
    while index < items.length do
      cart_item = items[index.to_s]
      lineitem = LineItem.new(:action => "sold", :quantity => cart_item[1].to_i)
      actual_item = Item.where(:name => cart_item[0].to_s)[0]
      lineitem.item = actual_item
      lineitem.transaction = tx
      lineitem.save
      index += 1
    end    

    session[:cart] = Cart.new   
    render js: "window.location.href = '#{items_path}'"
  end

=begin
  def show
    @transaction = Transaction.find(params[:id])
    if not @user.admin? and @transaction.user_id != @user.id
      redirect_to action: "index"
    end
  end
=end

  def export
    @transactions = Transaction.all
    type = params[:type]
    file_ext = params[:file_ext]
    data = {
      Transactions: {
        CSV: Transaction.transactions_data(@transactions),
        XLS: Transaction.transactions_data(@transactions, col_sep: "\t")
      },
      Balances: {
        CSV: Transaction.balances_data,
        XLS: Transaction.balances_data(col_sep: "\t")
      }
    }
    respond_to do |format|
      format.html { send_data data[type.to_sym][file_ext.to_sym] }
    end  
  end

  # triggered by twitter typeahead
  def tquery
    # Get the search terms from the q parameter and do a search
    # Generates the list of suggested search items below the search bar
    current_user = User.where(uid: session[:cas_user])[0]

    if current_user.admin?
      search = Transaction.search(params[:q],fields: [{purpose: :word_start}], misspelling: {edit_distance: 2} , operator: "or")
    else
      search = Transaction.where(user_id: current_user.id).search(params[:q],fields: [{purpose: :word_start}], misspelling: {edit_distance: 2} , operator: "or")
    end

    respond_to do |format|
      format.json do
        # Create an array from the search results.
        results = search.results.map do |transaction|
          # Each element will be a hash containing only the title of the article.
          # The name key is used by typeahead.js.
          { purpose: transaction.purpose }
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
    update_trans
  end

  def update_trans
    get_trans_params
    get_trans
    paginate_trans
    save_trans_params
    render "tload"
  end

  private

  ## @transactions sorting logic

  def get_trans_params

    # get @phrase
    if should_find?
      @tphrase = params[:tphrase] || session[:tphrase]
    else
      @tphrase = nil
    end

    # get @sort_by and @sort_type
    if should_sort?
      @tsort_by = params[:tsort_by]
      @tsort_type = get_sort_type
    elsif sorted_before?
      @tsort_by, @tsort_type = session[:tsort_by], session[:tsort_type]
    else
      @tsort_by, @tsort_type = nil, nil
    end

    # get @page
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end

  end

  def should_find?
    params.has_key?(:tphrase) || session.has_key?(:tphrase) 
  end

  def should_sort?
    params.has_key?(:tsort_by)
  end

  def sorted_before?
    session.has_key?(:tsort_by)
  end

  def get_sort_type
    if !sorted_before?
      # accounts for first time sorting in current session
      @tsort_type = 'ascending'  
    elsif sorted_before? && (params[:tsort_by] == session[:tsort_by])
      # accounts for clicking an already sorted column to change the sort type (ascending <-> descending)
      session[:tsort_type] == 'ascending' ? (@tsort_type = 'descending') : (@tsort_type = 'ascending')
    elsif sorted_before? && (params[:tsort_by] != session[:tsort_by])
      # accounts for having sorted one column and now sorting a different column
      @tsort_type = 'ascending'
    end
  end

  # remember recent inventory conditions (search & sort)
  def save_trans_params
    session[:tphrase] = @tphrase
    session[:tsort_by] = @tsort_by
    session[:tsort_type] = @tsort_type
  end

  def clear_sort_session
    session[:tphrase] = nil
    session[:tsort_by] = nil
    session[:tsort_type] = nil
  end

  # get @transactions
  def get_trans
    # according to search phrase
    get_searched_trans
    # according to sorting params
    Transaction.sort(@transactions, @tsort_by, @tsort_type)
  end

  # searched by @phrase
  def get_searched_trans

      current_user = User.where(uid: session[:cas_user])[0]

    if @tphrase.blank?
      if @currently_admin
        @transactions = Transaction.all
      else
        @transactions = Transaction.where(user_id: current_user.id)
      end
    else
      if @currently_admin
        @transactions = Transaction.search(@tphrase, fields: [{purpose: :word_start}], misspelling: {edit_distance: 2}, operator: "or").to_ary
      else
        @transactions = Transaction.where(user_id: current_user.id).search(@tphrase, fields: [{purpose: :word_start}], misspelling: {edit_distance: 2}, operator: "or").to_ary
      end
    end
  end

  def paginate_trans
    @transactions = Kaminari.paginate_array(@transactions).page(@page).per(12)
  end

end
