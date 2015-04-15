class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :item_id
      t.integer :quantity
      t.string :action
      t.timestamps
    end
  end
end
