class AddUserUid < ActiveRecord::Migration
  def up
  end
  def down
  end

  def change
    add_column :users, :uid, :integer
  end
end
