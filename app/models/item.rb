class Item < ActiveRecord::Base
  attr_accessible :name, :quantity, :price, :kind, :status
  belongs_to :location
  has_many :transactions
  @@allowed_status = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => @@allowed_status }
  validates :name, :price, :quantity, :kind, presence: true
  validates :price, :quantity, numericality: true

  def self.sort(sort_by, sort_type, new_sort)
    if new_sort
      items = Item.order(sort_by)
    else
      sort_type == 'ascending' ? (items = Item.order(sort_by)) : (items = Item.order(sort_by).reverse_order)
    end
  end
  
  def Item.all_status
    @@allowed_status
  end
end
