class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :purpose

      t.timestamps
    end
  end
end
