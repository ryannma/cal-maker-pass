class Item < ActiveRecord::Base
  attr_accessible :name, :price, :price, :quantity, :status, :mytype
  belongs_to :location
  has_many :transactions
  #validates :status, :inclusion=> { :in => @allowed_types }
  #@allowed_types = ["lend", "sell", "both"]
end

def is_valid
  if :status == "lend" || :status == "sell" || :status == "both"
    return true
  else
    return false
  end
end
