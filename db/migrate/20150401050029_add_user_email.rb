class AddUserEmail < ActiveRecord::Migration
  def up
  end

  def down
  end
  def change
    add_column :users, :email, :string
  end
end
