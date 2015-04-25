class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :check_user_exists, :except => [:logout, :signup]

  def home
    if @user.admin?
      redirect_to "/items"
    else
      redirect_to "/items"
    end
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  private

  def check_user_exists
    @user = User.where(uid: session[:cas_user]).first
    if @user.nil?
      redirect_to "/signup"
    end
  end


end
