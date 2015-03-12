class Transaction < ActiveRecord::Base
  attr_accessible :, :, :purpose, :type
  belongs_to :item
  belongs_to :user
  validates :type, :inclusion=> { :in => @allowed_types }
  @allowed_types = ["bought", "lent", "sold"]
end
