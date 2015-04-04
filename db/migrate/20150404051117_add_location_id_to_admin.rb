class AddLocationIdToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :location_id, :integer
  end
end
