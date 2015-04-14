class UsersController < ApplicationController
  before_filter :check_user_exists, :except => [:new]

  def new
  end

end
