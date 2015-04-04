class TransactionsController < ApplicationController

  def index
    puts params[:cart]
    # user_id = params[:user_id]
    # admin_id = params[:admin_id]
    # Transaction.where(user_id: user_id, admin_id: admin_id).all
  end

=begin
   def index
     user_id = params[:user_id]
     admin_id = params[:admin_id]
     Transaction.where(user_id: user_id, admin_id: admin_id).all
   end

   def show
     trans_id = params[:trans_id]
     params[:transaction] = Transaction.find_by_id(trans_id)
   end

   def new
     params[:items] = [params[:item]]
     redirect_to action: :new_bulk
   end

   def new_bulk
     render :new_bulk
   end

   def create
     user_id = params[:user_id]
     admin_id= params[:admin_id]
     items = params[:items]
     trans_types = params[:types]
     trans = Transaction.create!({item: item_id, user: user_id, admin: admin_id, mytype: trans_type})
     params[:trans_id] = trans.id
     flash[:notice] = "Successfully completed the transactions"
     redirect_to action: :show
   end
=end

   def create_bulk
     trans_items = params[:items]
     user_id = params[:user_id]
     admin_id= params[:admin_id]
     trans_ids = []
     trans_items.each do |trans_item|
       trans_ids << Transaction.create!({item: trans_item[:item], user: user_id, admin: admin_id, mytype: trans_item[:trans_type]}).id
     end
     redirect_to action: :index
   end

   def order
   end

end