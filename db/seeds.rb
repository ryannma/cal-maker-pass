#Initialization of basic stuff
User.create(:first_name=>"John", :last_name=>"Doe", :sid=>"25325674", :uid=>"432175", :email=>"tempemail@gmail.com")
Location.create(:name=>"Invention Lab")
invention_lab = Location.first
a = Admin.create()
a.user = User.first
a.location = invention_lab
a.save

#Creating items in invention lab
i1 = Item.create(:name=>"Raspberry Pi 2", :quantity=>5, :price=>34.99, :kind=>"Hardware", :status=>"sell")
i2 = Item.create(:name=>"Capacitor 5V", :quantity=>100, :price=>0.10, :kind=>"EE", :status=>"sell")
i3 = Item.create(:name=>"Red LED", :quantity=>23, :price=>1.00, :kind=>"Component", :status=>"sell")
i4 = Item.create(:name=>"Fiberboard", :quantity=>5, :price=>0.25, :kind=>"Raw Material", :status=>"sell")
[i1, i2, i3, i4].each do |item|
  item.location = invention_lab
  item.save
end

#Creating transactions
tx1 = Transaction.create(:purpose=> "cs169")
lItem1 = LineItem.create(:action => "sold", :quantity=> 5)
lItem1.item = Item.find(1)
lItem2 = LineItem.create(:action => "sold", :quantity=> 2)
lItem2.item = Item.find(3)
[lItem1, lItem2].each do |lItem|
  lItem.transaction = tx1
  lItem.save
end

tx2 = Transaction.create(:purpose=> "cs168")
lItem1 = LineItem.create(:action => "sold", :quantity=> 7)
lItem1.item = Item.find(2)
lItem2 = LineItem.create(:action => "sold", :quantity=> 2)
lItem2.item = Item.find(4)
[lItem1, lItem2].each do |lItem|
  lItem.transaction = tx2
  lItem.save
end

[tx1, tx2].each do |tx|
  tx.user = User.first
  tx.admin = Admin.first
  tx.save
end