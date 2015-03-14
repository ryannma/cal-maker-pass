class Transaction < ActiveRecord::Base
  attr_accessible :purpose, :type
  belongs_to :item
  belongs_to :user
  belongs_to :admin
  allowed_types = ["lent", "sold"]
  validates :mytype, :inclusion=> { :in => allowed_types }
  
end

def is_valid
  if :status == "lent" || :status == "sold"
    return true
  else
    return false
  end
end
