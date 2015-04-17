class TransactionsController < ApplicationController

  def index
<<<<<<< HEAD

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

    if @all == false || @all == "false"
      if @sort == 'customer'
        @transactions = Transaction.where(admin_id: admin_user.id).includes(:user).order("users.last_name")
      elsif @sort == 'purpose'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:purpose)
      elsif @sort == 'date'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:created_at)
      else
        @transactions = Transaction.where(admin_id: admin_user.id)
      end
    else
      if @sort == 'customer'
        @transactions = Transaction.includes(:user).order("users.last_name")
      elsif @sort == 'purpose'
        @transactions = Transaction.order(:purpose)
      elsif @sort == 'date'
        @transactions = Transaction.order(:created_at)
      else
        @transactions = Transaction.all
      end
    end
  end


  def checkout
    admin_user = User.where(uid: session[:uid])
    admin = Admin.where(user_id: admin_user.id)
    cart = params[:cart]
    user = User.where(id: cart.user.id)
    tx = Transaction.new(:purpose=>cart.comment)
    tx.user = user
    tx.admin = admin
    tx.save
    items = cart.items
    items.each do |cart_item|
      lineitem = LineItem.new(:action => "sold", :quantity => cart_item.quantity)
      inventory_item = Item.where(id: cart_item.item_id())
      lineitem.item = inventory_item
      lineitem.transaction = tx
      lineitem.save
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end

