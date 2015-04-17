class Transaction < ActiveRecord::Base
  attr_accessible :purpose
  belongs_to :user
  belongs_to :admin
  has_many :line_items
end
