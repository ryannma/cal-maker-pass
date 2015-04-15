class Admin < ActiveRecord::Base
  attr_accessible :title, :body
  belongs_to :location
  has_one :user
  has_many :transactions
end
