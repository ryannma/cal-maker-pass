Given /the following transaction exists/ do |transactions_table|
  tx = Transaction.create()
  tx.user = User.find(1)
  tx.admin = Admin.find(1)
  tx.save
  transactions_table.hashes.each do |item|
    lineItem = LineItem.create()
    lineItem.item = Item.find_by_name(item[:name])
    lineItem.action = item[:type]
    lineItem.quantity = item[:quantity]
    lineItem.transaction = tx
    lineItem.save
  end
end

When /^(?:|I )add "(.*)" to cart$/ do |item|
  step "I go to the items page"
  step "I follow \"cart-button\""
  find("#add-#{item}").click
end

When /^(?:|I )remove "(.*)" from cart$/ do |item|
  step "I go to the items page"
  step "I follow \"cart-button\""
  find("#delete-#{item}").click
end

When /^(?:|I )click checkout$/ do
  if have_css(".cart-panel-hidden") != nil
    find("#cart-button").click
  end
  Capybara.ignore_hidden_elements = true
  find("#checkout-button").click
  Capybara.ignore_hidden_elements = false
end

When /^(?:|I )click all$/ do 
  find(".button-blue").click
end

When /^(?:|I )click own$/ do
  find(".button-red").click
end

When /^(?:|I )enter (\d+) as my SID$/ do |sid|
  step "I go to the items page"
  find("#cart-button").click
  fill_in 'transaction_user', :with => sid
end

When /^(?:|I )click transaction (\d+)$/ do |transaction_id|
  within('#transaction-table') do
    page.find(:xpath, "//a[@href='/transactions/#{transaction_id}']").click
  end
end

When /^(?:|I )sort by (.*)$/ do |sort_key|
  within('#transaction-table') do
    page.find(:xpath, "//a[@href='/transactions?sort=#{sort_key}']").click
  end
end

Then /^(?:|I )should see an alert$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^(?:|I )should see "(.*)" in cart$/ do |item|
  page.find("#cart-items").should have_content(item)
end

Then /^(?:|I )should not see "(.*)" in cart$/ do |item|
  page.find("#cart-items").should_not have_content(item)
end

Then /^(?:|I )should see (\d+) (?:transaction|transactions)$/ do |number_of_rows|
  expect(page).to have_selector('.clickable_row', count: number_of_rows)
end