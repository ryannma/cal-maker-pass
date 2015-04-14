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


