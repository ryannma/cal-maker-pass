class Transaction < ActiveRecord::Base
	attr_accessible :purpose, :line_items
	belongs_to :user
	belongs_to :admin
	has_many :line_items

	# sort transactions array in place
	def self.sort(transactions, sort_trans_by, sort_trans_type, all, admin_user)
		puts '@@@@ were in sort @@@@'
		puts transactions
		puts sort_trans_by
		puts sort_trans_type
		puts all
		puts admin_user
		puts '@@@@ done @@@@'
		if all == true || all == 'true'
			if sort_trans_by
				if sort_trans_by == 'customer'
					sort_trans_type == 'ascending' ? (transactions.sort! { |a,b| a.user.name.downcase <=> b.user.name.downcase }) : (transactions.sort! { |a,b| b.user.name.downcase <=> a.user.name.downcase })
				elsif sort_trans_by == 'purpose'
					sort_trans_type == 'ascending' ? (transactions.sort! { |a,b| a.purpose.downcase <=> b.purpose.downcase }) : (transactions.sort! { |a,b| b.purpose.downcase <=> a.purpose.downcase })
				elsif sort_trans_by == 'date'
					sort_trans_type == 'ascending' ? (transactions.sort! { |a,b| a.created_at <=> b.created_at}) : (transactions.sort! { |a,b| b.created_at <=> a.created_at})
				end
			end
		end
	end

	def self.transactions_data(transactions, options = {})
		csv_headers = ["Date", "User", "Purpose", "Item", "Quantity", "Action"]
		CSV.generate(options) do |csv|
			csv << csv_headers
			transactions.each do |transaction|
				super_row = []
				super_row << transaction.created_at
				if (transaction.user == nil)
					super_row << 'unknown'
				else
					super_row << transaction.user.name
				end
				super_row << transaction.purpose
				transaction.line_items.each do |line_item|
					sub_row = Array.new(super_row)
					sub_row << line_item.item.name
					sub_row << line_item.quantity
					sub_row << line_item.action
					csv << sub_row
				end
			end
		end
	end

	def self.balances_data(options = {})
		csv_headers = ["SID", "User", "Balance"]
		CSV.generate(options) do |csv|
			csv << csv_headers
			Transaction.unique_users.each do |user|
				row = []
				if user != nil
					row << user.sid
					row << user.name
					row << user.balance.to_s
					csv << row
				end
			end
		end
	end

	def self.unique_users
		users = []
		Transaction.all.each do |transaction|
			users << transaction.user
		end
		users.uniq
	end

	def cost
		total = 0
		self.line_items.each do |line_item|
			total += line_item.item.price * line_item.quantity
		end
		total
	end

end
