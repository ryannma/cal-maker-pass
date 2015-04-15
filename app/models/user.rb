class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :sid, :uid, :email
  has_and_belongs_to_many :locations
  has_many :items, through: :transactions
  has_many :transactions

  def name
    return "#{first_name} #{last_name}"
  end

  def admin?
    admin = Admin.where(user_id: @id)
    if admin.empty?
      return false
    else
      return true
    end
  end

end
