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
  step "I accept the pop-up"
end

When /^(?:|I )see details of (.*)$/ do |item|
  find("#edit-#{item}").click
end

When /^(?:|I )edit (.*) of (.*) to (.*)$/ do |field_name, item, value|
  step "I go to the items page"
  step "I see details of #{item}"
  step "I fill in \"#{field_name}\" with \"#{value}\""
  find("#show-item-update").click
end

Then /^(?:|I )delete (.*)$/ do |item|
  find("#show-item-delete").click
end

When /^(?:|I )sort items by (.*)$/ do |sort_key|
  within('#inventory-table') do
    find("\##{sort_key}.header").click
  end
end

When /^(?:|I )click next page$/ do
  click_link('Next >')
end

When /^(?:|I )search for (.*)$/ do |item_name|
  fill_in 'phrase', :with => item_name
  find("#phrase").native.send_keys("\n") 
end

