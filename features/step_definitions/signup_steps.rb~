Given /a user is calnet logged in/ do
  CASClient::Frameworks::Rails::Filter.fake("homer")
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
