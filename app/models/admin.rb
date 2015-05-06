class Admin < ActiveRecord::Base
  attr_accessible :superadmin
  belongs_to :location
  belongs_to :user
  has_many :transactions

  def method_missing(method_sym, *arguments, &block)
    user.method(method_sym).call(*arguments)
  end
  
end
