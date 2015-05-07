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
      if not admins.where(superadmin: true).empty?
        lvl = 2
      end
    end
    lvl
  end

  def delete
    Admin.delete(admins)
    super
  end

  def grant_privilege(new_privilege_lvl)
    is_superadmin = new_privilege_lvl == 2
    if new_privilege_lvl == privilege_lvl
      return
    elsif new_privilege_lvl == 0
      Admin.delete(admins)
    elsif admin?
      admins.each do |admin|
        admin.superadmin = is_superadmin
        admin.save
      end
    else
      admin = Admin.new(:superadmin => is_superadmin)
      admin.user_id = id
      admin.save
    end
  end

end
