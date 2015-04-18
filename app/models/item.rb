class Item < ActiveRecord::Base
  attr_accessible :name, :quantity, :price, :kind, :status
  belongs_to :location
  has_many :line_items
  @@allowed_status = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => @@allowed_status }
  validates :name, :price, :quantity, :kind, presence: true
  validates :price, :quantity, numericality: true

  def self.sort(sort_by, sort_type, items)
    if sort_by
      sort_type == 'ascending' ? (items.sort! { |a,b| a.name.downcase <=> b.name.downcase }) : (items.sort! { |a,b| a.name.downcase <=> b.name.downcase }.reverse)
    else
      items
    end
  end
  
  searchkick word_start: [:name]

  def Item.all_status
    @@allowed_status
  end
end