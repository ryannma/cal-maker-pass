class LineItem < ActiveRecord::Base
  attr_accessible :action, :quantity
  belongs_to :item
  belongs_to :transaction
  allowed_types = ["sold", "lent", "returned"]
  validates :action, :inclusion=> { :in => allowed_types }
end
