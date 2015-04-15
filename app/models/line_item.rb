class Transaction < ActiveRecord::Base
  attr_accessible :action, :quantity
  belongs_to :item
  allowed_types = ["sold", "lent", "returned"]
  validates :action, :inclusion=> { :in => allowed_types }
end
