class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :items
  has_many :admins
  has_and_belongs_to_many :users
end
