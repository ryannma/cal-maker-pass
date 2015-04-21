class Item < ActiveRecord::Base
  attr_accessible :name, :quantity, :price, :kind, :status
  belongs_to :location
  has_many :line_items
  @@allowed_status = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => @@allowed_status }
  validates :name, :price, :quantity, :kind, presence: true
  validates :price, :quantity, numericality: true

  # sort items array in place
  def self.sort(items, sort_by, sort_type)
    if sort_by
      if sort_by == 'name' || sort_by == 'kind' || sort_by == 'status'
        sort_type == 'ascending' ? (items.sort! { |a,b| a[sort_by].downcase <=> b[sort_by].downcase }) : (items.sort! { |a,b| b[sort_by].downcase <=> a[sort_by].downcase })
      else
        sort_type == 'ascending' ? (items.sort! { |a,b| a[sort_by] <=> b[sort_by]}) : (items.sort! { |a,b| b[sort_by] <=> a[sort_by]})
      end
    end
  end
  
  searchkick word_start: [:name]

  def self.all_status
    @@allowed_status
  end

end