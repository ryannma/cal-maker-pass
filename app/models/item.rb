class Item < ActiveRecord::Base
  attr_accessible :name, :price, :quantity, :status, :kind
  belongs_to :location
  has_many :transactions
  @@allowed_status = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => @@allowed_status }
  validates :name, :price, :quantity, :kind, presence: true
  validates :price, :quantity, numericality: true

  # def is_valid
  #   if :status == "lend" || :status == "sell" || :status == "both"
  #     return true
  #   else
  #     return false
  #   end
  # end

  def Item.all_status
    @@allowed_status
  end

end