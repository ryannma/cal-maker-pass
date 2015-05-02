class UsersController < ApplicationController
  before_filter :check_user_exists, :except => [:new, :create]

  def new
    if not @user.nil?
      redirect_to "/"
    end
  end

  def create
    if not @user.nil?
      redirect_to "/"
    end
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
    if @privilege.nil?
      query, method, model = {}, 'all', 'User'
    elsif @privilege == 'admin'
      query, method, model = {}, 'where', 'Admin'
    else
      query, method, model = {:superadmin => true}, 'where', 'Admin'
    end
    @users = model.constantize.method(method).call(query)
  end

  def edit
    privilege_lvl = @user.privilege_lvl
    filter_user 1
    privileges = ['None', 'Seller', 'Manager']
    @available_privileges = []
    privileges.each_with_index do |privilege, index|
      if index <= privilege_lvl
        @available_privileges << [privilege, index]
      else
        break
      end
    end
    respond_to do |format|
      format.js {}
    end
  end

  def update
    passes = sanity_check_privilege
    if not passes
      flash[:warning] = "You don't have the privilege to promote that user"
      redirect_to action: "edit", flash: flash
    end
    filter_user 1
    @updated_data = params[:user]
    @user.first_name = @updated_data[:first_name]
    @user.last_name = @updated_data[:last_name]
    @user.sid = @updated_data[:sid]
    @user.email = @updated_data[:email]
    if @user.id != params[:id] or @user.privilege_lvl == params[:privilege]
      grant_privilege params[:privilege]
    end
    @user.save!
    # IMPLEMENT: Render something here
  end

  def show
    filter_user 1
  end

  def destroy
    filter_user 2
    if @user.id == params[:id]
      @user.destroy
      flash[:notice] = "Successfully deleted user"
    else
      flash[:warning] = "You don't have permissions to delete user"
    end
    redirect_to action: "index", flash: flash
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
    privilege_lvl = @user.privilege_lvl
    if privilege_lvl >= minimum_privilege_lvl
      @user = User.find(params[:id])
    end
  end

  def sanity_check_privilege
    return params[:privilege] <= @user.privilege_lvl
  end

  def grant_privilege(new_privilege_lvl)
    is_superadmin = new_privilege_lvl == 2
    if new_privilege_lvl == 0
      @user.admins.delete
    elsif @user.admin?
      @user.admins.each do |admin|
        admin.superadmin = is_superadmin
        admin.save
      end
    else
      admin = Admin.new(:superadmin => is_superadmin)
      admin.user = @user
      admin.save
    end
  end

end
