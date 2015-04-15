class TransactionsController < ApplicationController

  def index
    @current_user = User.where(uid: session[:uid])
    @is_admin = false
  end
end


