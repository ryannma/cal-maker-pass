class UsersController < ApplicationController
  before_filter :check_user_exists, :except => [:new, :create]

  def new
    check_user_exists nil
    filter_user 3 or return
  end

  def create
    check_user_exists nil
    filter_user 3 or return
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
    redirect_to "/", flash: flash
  end

  def index
    @privilege = params[:privilege]
    if @privilege.nil? and @user.privilege_lvl > 0
      query, method, model = {}, 'all', 'User'
      @active_user_button = 'all'
    elsif @privilege == 'self' or (@user.privilege_lvl == 0 and @privilege.nil?)
      query, method, model = {:id => @user.id}, 'where', 'User'
      @active_user_button = 'self'
    elsif @privilege == 'admin'
      query, method, model = {}, 'where', 'Admin'
      @active_user_button = 'sellers'
    else
      query, method, model = {:superadmin => true}, 'where', 'Admin'
      @active_user_button = 'managers'
    end
    @admin_ids = []
    @user.admins.each do |admin|
      @admin_ids << admin.id
    end
    @users = model.constantize.method(method).call(query)
  end

  def edit
    admin_privilege_lvl = @user.privilege_lvl
    sanity_check_privilege; return if performed?
    user_privilege_lvl = @user.privilege_lvl
    privileges = ['None', 'Seller', 'Manager']
    @available_privileges = []
    privileges.each_with_index do |privilege, index|
      if index <= admin_privilege_lvl
        is_selected = user_privilege_lvl == index
        @available_privileges << [privilege, index, is_selected]
      else
        break
      end
    end
    @admin_privilege = admin_privilege_lvl
    @user_privilege = user_privilege_lvl
    respond_to do |format|
      format.js {}
    end
  end

  def update
    admin_privilege_lvl, admin_user_id = @user.privilege_lvl, @user.id
    sanity_check_privilege; return if performed?
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.sid = params[:sid]
    @user.email = params[:email]
    if @user.id != admin_user_id
      @user.grant_privilege params[:privilege].to_i
    elsif params[:privilege].to_i != admin_privilege_lvl
      flash[:warning] = "Cannot modify your own privleges"
    end
    @user.save!
  end

  def show
    filter_user 1 or return
  end

  def destroy
    admin_user_id = @user.id
    sanity_check_privilege true; return if performed?
    user_id = @user.id
    @user.delete
    flash[:notice] = "Successfully deleted user"
  end

  def find
    # IMPLEMENT: add search functionality with pagination
  end

private

  def filter_user(minimum_privilege_lvl)
    # For certain controller actions, the user should only be granted access
    # if the user has a minimum privilege level. If minimum privilege level
    # is not reached, will default back to the requesting user.
    #
    # An example: User 1 wants to edit information for User 2 but doesn't have
    # seller access. Thus, User 1 will only be able to edit his/her information.
    if @user.nil?
      @user = User.new()
    elsif @user.privilege_lvl >= minimum_privilege_lvl
      if not params[:id].nil?
        @user = User.find(params[:id])
      end
    else
      redirect_to(action: "index", status: 303, flash: flash) and return
    end
  end

  def sanity_check_privilege(strict=false)
    admin_privilege_lvl = @user.privilege_lvl
    admin_user_id = @user.id
    @user = User.find(params[:id])
    user_id = @user.id
    user_privilege_lvl = @user.privilege_lvl
    if strict
      checker = (user_privilege_lvl >= admin_privilege_lvl)
    elsif
      checker = (user_privilege_lvl >= admin_privilege_lvl and admin_user_id != user_id)
    end
    if checker
      flash[:warning] = "You don't have permission to modify this user"
      redirect_to(action: "index", status: 303, flash: flash) and return
    end
  end

  def print(printable)
    puts "@@@@@@@@@@@@@@@@@@@@@@"
    puts printable
    puts "######################"
  end
end
