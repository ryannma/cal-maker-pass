class Admin < ActiveRecord::Base
  attr_accessible :title, :body
  belongs_to :location
  belongs_to :user
end
