class TransactionsController < ApplicationController

  def index
    @current_user = User.find_by uid: session[:uid]
    @current_admin = Admin.find_by user_id: @current_user.id
    #@is_admin = true
    if @current_admin.nil?
    	#@is_admin = false
	@transactions = Transaction.where(user_id: @current_user.id)
    else
        @transactions = Transaction.where(admin_id: @current_admin.id)
    end
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.valid?
      @transaction.save
    else
      errors=@item.errors.full_messages.join("<br>").html_safe
      puts errors
      flash[:warning] = errors
    end
    redirect_to items_path

  def delete
    @transaction = Transaction.find(params[:id])
    @trasaction.destroy
    redirect_to transactions_path
  end

  def checkout
    user_id = session[:cas_user]
    user = User.find_by_uid(user_id)
    admin_id = params[:admin_id]
    admin = Admin.find(admin_id)
    purpose = params[:purpose]
    cart = params[:cart]
    cart.each do |item|
      item = Item.find(item[:id])
      Transaction.create(user: user, admin: admin, purpose: purpose, kind: item.kind, item: item)
    end
    redirect_to items_path
  end


  def create_bulk
    trans_items = params[:items]
    user_id = params[:user_id]
    admin_id= params[:admin_id]
    trans_ids = []
    trans_items.each do |trans_item|
      trans_ids << Transaction.create!({item: trans_item[:item], user: user_id, admin: admin_id, mytype: trans_item[:trans_type]}).id
    end
    redirect_to action: :index
  end
 end

end

