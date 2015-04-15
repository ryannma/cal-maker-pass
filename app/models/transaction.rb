class Transaction < ActiveRecord::Base
  attr_accessible :purpose
  belongs_to :user
  belongs_to :admin
  has_many :lineitems
  allowed_types = ["lent", "sold"]
  validates :kind, :inclusion=> { :in => allowed_types }
  
end
