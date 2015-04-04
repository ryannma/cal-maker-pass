class AddItemIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :item_id, :integer
  end
end
