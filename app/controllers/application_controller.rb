class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter CASClient::Frameworks::Rails::Filter

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
