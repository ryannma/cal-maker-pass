class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :sid
  has_and_belongs_to_many :locations
  has_many :items, through: :transactions
  has_many :transactions
end
