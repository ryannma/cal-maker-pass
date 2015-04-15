class AddTransactionIdToLineItems < ActiveRecord::Migration
  def change
    add_column :lineitems, :transaction_id, :integer
  end
end
