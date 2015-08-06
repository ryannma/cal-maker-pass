class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :check_user_exists, :except => [:logout, :signup] 
  before_filter :current_user_is_admin

  def home
    if @user.admin?
      redirect_to "/items"
    else
      redirect_to "/items"
    end
  end

  def logout
    #session.clear
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  private

  def check_user_exists(success_route = "/signup")
    @user = User.where(uid: session[:cas_user]).first
    if @user.nil? and not success_route.nil?
      redirect_to success_route
    end
  end

  def current_user_is_admin
    current_user = User.where(uid: session[:cas_user])[0]
    @currently_admin = false
  end

end
