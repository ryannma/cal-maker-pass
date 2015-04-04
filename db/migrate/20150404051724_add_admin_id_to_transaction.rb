class AddAdminIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :admin_id, :integer
  end
end
