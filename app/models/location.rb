class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :item
  has_many :admin
  has_and_belongs_to_many :users
end
