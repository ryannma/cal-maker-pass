class AddTransactionIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :transaction_id, :integer
  end
end
