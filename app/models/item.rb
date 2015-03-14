class Item < ActiveRecord::Base
  attr_accessible :name, :price, :quantity, :status, :kind
  belongs_to :location
  has_many :transactions
  allowed_types = ["lend", "sell", "both"]
  validates :status, :inclusion=> { :in => allowed_types }
  
end

def is_valid
  if :status == "lend" || :status == "sell" || :status == "both"
    return true
  else
    return false
  end
end
