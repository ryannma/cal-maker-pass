class Item < ActiveRecord::Base
  attr_accessible :name, :quantity, :price, :kind, :status
  belongs_to :location
  has_many :transactions
  @@allowed_status = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => @@allowed_status }
  validates :name, :price, :quantity, :kind, presence: true
  validates :price, :quantity, numericality: true

  searchkick word_start: [:name]

  def Item.all_status
    @@allowed_status
  end
end