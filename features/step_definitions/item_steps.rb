Given /the following items exist/ do |items_table|
  items_table.hashes.each do |item|
	Item.create(item)
  end
end

When /^(?:|I )manually add item: (.+), (.+), (.+), (.+), (.+)/ do |name, price, quantity, status, kind|
  step "I go to the items page"
  step "I press \"Add\""
  step "I fill in \"Name\" with \"#{name}\""
  step "I fill in \"Price\" with \"#{price}\""
  step "I fill in \"Quantity\" with \"#{quantity}\""
  #step "I fill in \"Status\" with " + "\"" + status + "\""
  page.select(status, :from => 'selecttype')
  step "I fill in \"Type\" with \"#{kind}\""
  step "I press \"Add\""
end