class ChangeTypeColumns < ActiveRecord::Migration
  def up
  end

  def down
  end
  def change
    rename_column :items, :type, :kind
    rename_column :transactions, :type, :kind
  end
end
