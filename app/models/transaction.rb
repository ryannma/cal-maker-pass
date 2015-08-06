class Transaction < ActiveRecord::Base
	attr_accessible :purpose, :line_items
	belongs_to :user
	belongs_to :admin
	has_many :line_items

	searchkick word_start: [:purpose]

	# sort items array in place
	def self.sort(transactions, tsort_by, tsort_type)
		if tsort_by
		  if tsort_by == 'purpose'
		    tsort_type == 'ascending' ? (transactions.sort! { |a,b| a[tsort_by].downcase <=> b[tsort_by].downcase }) : (transactions.sort! { |a,b| b[tsort_by].downcase <=> a[tsort_by].downcase })
		  elsif tsort_by == 'date'
		    tsort_type == 'ascending' ? (transactions.sort! { |a,b| a[:updated_at] <=> b[:updated_at]}) : (transactions.sort! { |a,b| b[:updated_at] <=> a[:updated_at]})		  	
		  elsif tsort_by == 'customer'
		    tsort_type == 'ascending' ? (transactions.sort! { |a,b| a.user.name <=> b.user.name}) : (transactions.sort! { |a,b| b.user.name <=> a.user.name})
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
