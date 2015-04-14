class UsersController < ApplicationController
  before_filter :check_user_exists, :except => [:new, :create]

  def new
    @all_locations = Location.all
  end

  def create
    user_params = params[:user]
    user_params[:uid] = session[:cas_user]
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      flash[:notice] = "Your account has been created"
    else
      errors = @user.errors.full_messages.join("<br>").html_safe
      puts errors
      flash[:warning] = errors
    end
    redirect_to "/"
  end

end
