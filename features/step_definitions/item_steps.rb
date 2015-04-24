Given /the following items exist/ do |items_table|
  items_table.hashes.each do |item|
	Item.create(item)
  end
end

And /a user is logged in/ do
  CASClient::Frameworks::Rails::Filter.fake("homer")

  step "I go to the signup page"
  step "I fill in \"First Name\" with \"first\""
  step "I fill in \"Last Name\" with \"last\""
  step "I fill in \"Email\" with \"email@berkeley.edu\""
  step "I fill in \"Student ID\" with \"12345678\""
  step "I press \"Sign Up\""

end


When /^(?:|I )manually add item: (.*), (.*), (.*), (.*), (.*)/ do |name, price, quantity, status, kind|
  step "I go to the items page"
  step "I follow \"new-item-button\""
  step "I fill in \"Name\" with \"#{name}\""
  step "I fill in \"Price\" with \"#{price}\""
  step "I fill in \"Quantity\" with \"#{quantity}\""
  #step "I fill in \"Status\" with " + "\"" + status + "\""
  page.select(status, :from => 'Status')
  step "I fill in \"Type\" with \"#{kind}\""
  step "I press \"Add\""
end
