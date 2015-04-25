class TransactionsController < ApplicationController

  def index
    current_user = User.where(uid: session[:cas_user])[0]
    admin_user = Admin.find_by_user_id(current_user.id)

    if params.has_key?(:sort)
      @sort = params[:sort]
      session[:sort] = params[:sort]
    elsif session.has_key?(:sort)
      @sort = session[:sort]
      need_redirect = true
    else
      @sort = nil
    end

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

    if (@all == false && admin_user != nil) || (@all == "false" && admin_user != nil)
      if @sort == 'customer'
        @transactions = Transaction.where(admin_id: admin_user.id).includes(:user).order("users.last_name")
      elsif @sort == 'purpose'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:purpose)
      elsif @sort == 'date'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:created_at)
      else
        unless admin_user.nil?
          @transactions = Transaction.where(admin_id: admin_user.id)
        else
          @transactions = []
        end
      end
    elsif @all == true || @all == "true"
      if @sort == 'customer'
        @transactions = Transaction.includes(:user).order("users.last_name")
      elsif @sort == 'purpose'
        @transactions = Transaction.order(:purpose)
      elsif @sort == 'date'
        @transactions = Transaction.order(:created_at)
      else
        @transactions = Transaction.all
      end
    else
      @transactions = []
    end
  end


  def checkout
    items = params[:items]
    admin_user = User.where(uid: session[:cas_user])[0]
    admin = Admin.where(user_id: admin_user.id)[0]
    if admin.nil?
      admin = Admin.find(1)
    end
    buyer = User.where(sid: params[:buyer])[0];
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
    session[:cart] = nil
    render :nothing => true
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
