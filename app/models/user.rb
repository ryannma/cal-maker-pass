class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :sid, :uid, :email
  has_and_belongs_to_many :locations
  has_many :items, through: :transactions
  has_many :transactions
  has_many :admins

  def name
    return "#{first_name} #{last_name}"
  end

  def admin?
    if admins.empty?
      return false
    end
    return true
  end

  def balance
    total = 0
    self.transactions.each do |transaction|
      total += transaction.cost
    end
    total
  end

  def privilege_lvl
    lvl = 0
    if admin?
      lvl = 1
      if not admins.where(superadmin = true).empty?
        lvl = 2
      end
    end
    lvl
  end
end
