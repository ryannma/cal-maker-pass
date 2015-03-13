class Transaction < ActiveRecord::Base
  attr_accessible :purpose, :type
  belongs_to :item
  belongs_to :user
  belongs_to :admin
  #validates :mytype, :inclusion=> { :in => @allowed_types }
  #@allowed_types = ["lent", "sold"]
end

def is_valid
  if :status == "lent" || :status == "sold"
    return true
  else
    return false
  end
end
