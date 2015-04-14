class AddUserIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :user_id, :integer
  end
end
