class TransactionsController < ApplicationController

  def index
    current_user = User.where(uid: session[:cas_user])[0]
    admin_user = Admin.find_by_user_id(current_user.id)
    get_trans_params
    @transactions = Transaction.order(@sort_trans_by)
    save_trans_params

    @sort = sort_helper
    @all = view_helper
    @transactions = tx_helper(@all, @sort, admin_user)

    respond_to do |format|
      format.html
      format.csv { send_data Transaction.to_csv(@transactions) }
      format.xls { send_data Transaction.to_csv(@transactions, col_sep: "\t") }
    end
  end

  def sort_helper
    if params.has_key?(:sort)
      @sort = params[:sort]
      session[:sort] = params[:sort]
    elsif session.has_key?(:sort)
      @sort = session[:sort]
      need_redirect = true
    else
      @sort = nil
    end
  end

  def view_helper
    if params.has_key?(:all)
      @all = params[:all]
      session[:all] = params[:all]
    elsif session.has_key?(:all)
      @all = session[:all]
      need_redirect = true
    else
      @all = false
      session[:all] = false
    end
  end

  def tx_helper(all, sort, admin_user)
    if (all == false && admin_user != nil) || (all == "false" && admin_user != nil)
      @transactions = self_tx_helper(sort, admin_user)
    elsif all == true || all == "true"
      @transactions = all_tx_helper(sort, admin_user)
    else
      @transactions = []
    end
  end

  def self_tx_helper(sort, admin_user)
    if sort == 'customer'
      @transactions = Transaction.where(admin_id: admin_user.id).includes(:user).order("users.last_name")
    elsif sort == 'purpose'
      @transactions = Transaction.where(admin_id: admin_user.id).order(:purpose)
    elsif sort == 'date'
      @transactions = Transaction.where(admin_id: admin_user.id).order(:created_at)
    else
      unless admin_user.nil?
        @transactions = Transaction.where(admin_id: admin_user.id)
      else
        @transactions = []
      end
    end
  end

  def all_tx_helper(sort, admin_user)
    if sort == 'customer'
      @transactions = Transaction.includes(:user).order("users.last_name")
    elsif sort == 'purpose'
      @transactions = Transaction.order(:purpose)
    elsif sort == 'date'
      @transactions = Transaction.order(:created_at)
    else
      @transactions = Transaction.all
    end
  end

  def checkout
    items = params[:items]
    admin_user = User.where(uid: session[:cas_user])[0]
    admin = Admin.where(user_id: admin_user.id)[0]
    if admin.nil?
      admin = Admin.find(1)
    end
    buyer = User.find_by_sid(params[:buyer]);
    purpose = params[:purpose]
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
    render :nothing => true
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def sort
    get_trans_params
    @transactions = Transaction.all
    Transaction.sort(@transactions, @sort_trans_by, @sort_trans_type, @all, @admin_user)
    respond_to do |format|
      format.js{}
    end
    save_trans_params
  end

  private

  ## sorting logic

  def should_find?
    false
    #params.has_key?(:phrase) # || (session.has_key?(:phrase) && !session[:phrase].nil?) 
  end

  def should_sort?
    params.has_key?(:sort_trans_by)
  end

  def sorted_before?
    session.has_key?(:sort_trans_by) && !session[:sort_trans_by].nil?
  end

  # gets @sort_by, @sort_type, and @phrase
  def get_trans_params
    if should_sort?
      @sort_trans_by = params[:sort_trans_by]
      # accounts for first time sorting in current session
      if !sorted_before?
        @sort_trans_type = 'ascending'
      # accounts for clicking an already sorted column to change the sort type (ascending <-> descending)  
      elsif sorted_before? && (params[:sort_trans_by] == session[:sort_trans_by])
        session[:sort_trans_type] == 'ascending' ? (@sort_trans_type = 'descending') : (@sort_trans_type = 'ascending')
      # accounts for having sorted one column and now sorting a different column
      elsif sorted_before? && (params[:sort_trans_by] != session[:sort_trans_by])
        @sort_trans_type = 'ascending'
      end
    elsif sorted_before?
      @sort_trans_by, @sort_trans_type = session[:sort_trans_by], session[:sort_trans_type]
      # only store state of previous request
      #session[:sort_by], session[:sort_type] = nil, nil
    else
      @sort_trans_by, @sort_trans_type = nil, nil
    end
    # if should_find?
    #   params.has_key?(:phrase) ? (@phrase = params[:phrase]) : (@phrase = session[:phrase])
    # else
    #   @phrase = nil
    # end
    # @phrase = params[:phrase]
    @all = params[:all] || session[:all]
    @admin_user = params[:admin_user] || session[:admin_user]
  end

  # remember recent transaction conditions (filter & order)
  def save_trans_params
    # session[:phrase] = @phrase
    session[:sort_by] = @sort_by
    session[:sort_type] = @sort_type
    session[:all] = @all
    session[:admin_user] = @admin_user
  end

  def balances
    respond_to do |format|
      format.csv { send_data Transaction.balances_csv(@transaction) }
      format.xls { send_data Transaction.balances_csv(@transaction, col_sep: "\t") }
    end
  end

end
