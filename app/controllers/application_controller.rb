class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :check_user_exists

  def home
    if @user.admin?
      redirect_to action "/items"
    else
      redirect_to action "/items"
    end
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  private

  def check_user_exists
    @user = User.where(uid: session[:cas_user]).take
    if @user.empty?
      redirect_to action "/signup"
    end
  end

end
