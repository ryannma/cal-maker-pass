class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :sid
  has_and_belongs_to_many :locations
  has_many :items, through: :transactions
  has_many :transactions

  def self.from_omniauth(auth)
    user = User.where(:uid => auth[:uid])
    unless user
        User.new do |u|
            u.first_name = auth[:info][:first_name]
            u.last_name = auth[:info][:last_name]
            u.email = auth[:info][:email]
            u.uid = auth[:uid]
            u.save!
            return u
        end
    end
    return user
  end
end
