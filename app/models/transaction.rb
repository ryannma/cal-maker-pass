class Transaction < ActiveRecord::Base
  attr_accessible :purpose, :line_items
  belongs_to :user
  belongs_to :admin
  has_many :line_items

  # sort transactions array in place
  def self.sort(transactions, sort_trans_by, sort_trans_type, all, admin_user)
  	if @all == true || @all == "true"
	    if sort_trans_by
	      if sort_trans_by == 'customer' || sort_trans_by == 'purpose'
	        sort_trans_type == 'ascending' ? (transactions.sort! { |a,b| a[sort_by].downcase <=> b[sort_by].downcase }) : (transactions.sort! { |a,b| b[sort_by].downcase <=> a[sort_by].downcase })
	      else
	        sort_trans_type == 'ascending' ? (transactions.sort! { |a,b| a[sort_by] <=> b[sort_by]}) : (transactions.sort! { |a,b| b[sort_by] <=> a[sort_by]})
	      end
	    end
	end
  end

=begin
  if (@all == false && admin_user != nil) || (@all == "false" && admin_user != nil)
      if @sort == 'customer'
        @transactions = Transaction.where(admin_id: admin_user.id).includes(:user).order("users.last_name")
      elsif @sort == 'purpose'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:purpose)
      elsif @sort == 'date'
        @transactions = Transaction.where(admin_id: admin_user.id).order(:created_at)
      else
        unless admin_user.nil?
          @transactions = Transaction.where(admin_id: admin_user.id)
        else
          @transactions = []
        end
      end
  #@transactions = Transaction.includes(:user).order("users.last_name")
=end
 
end
