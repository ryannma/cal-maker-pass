class Transaction < ActiveRecord::Base
	attr_accessible :purpose
	belongs_to :user
	belongs_to :admin
	has_many :line_items

	def self.to_csv(transactions, options = {})
		csv_headers = ["Date", "User", "Purpose", "Item", "Quantity", "Action"]
		CSV.generate(options) do |csv|
			csv << csv_headers
			transactions.each do |transaction|
				super_row = []
				super_row << transaction.created_at
				if (transaction.user == nil)
					super_row << "unknown"
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

	def self.balances_csv(transactions, options = {})
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
