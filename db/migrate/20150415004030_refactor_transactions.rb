class RefactorTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :item_id
    remove_column :transactions, :kind
  end

  def down
    add_column :transactions, :item_id, :integer
    add_column :transactions, :kind, :string
  end
end
