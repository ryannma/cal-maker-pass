class TransactionsController < ApplicationController

  def index

    @current_user = User.where(uid: session[:uid])
    @is_admin = false

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

end

