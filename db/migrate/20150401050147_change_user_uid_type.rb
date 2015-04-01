class ChangeUserUidType < ActiveRecord::Migration
  def up
  end

  def down
  end
  def change
    change_column :users, :uid, :string
  end
end
