Given /the following items exist/ do |items_table|
  items_table.hashes.each do |item|
	Item.create(item)
  end
end

When /^(?:|I )manually add item: (.*), (.*), (.*), (.*), (.*)/ do |name, price, quantity, status, kind|
  step "I go to the items page"
  step "I follow \"new-item-button\""
  step "I fill in \"Name\" with \"#{name}\""
  step "I fill in \"Price\" with \"#{price}\""
  step "I fill in \"Quantity\" with \"#{quantity}\""
  page.select(status, :from => 'Status')
  step "I fill in \"Type\" with \"#{kind}\""
  find("#new-item-add").click
  page.driver.browser.switch_to.alert.accept
end
