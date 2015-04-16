class TransactionsController < ApplicationController

  def index

    @current_user = User.where(uid: session[:uid])
    @is_admin = false

  end

  def add
    admin = User.where(uid: session[:uid])
    user = User.where(params[:student_id])
    purpose = params[:purpose]
  end
end

