Feature: Checkout items

  As an admin
  I want to be able to checkout an order
  So that I can sell items to customers

Background: items have been added to the database
  
  Given the following items exist:
  | name | price | quantity | status | kind | 
  | capacitor | 4.0 | 5 | sell | EE |  
  | resistor | 4.0 | 1 | sell | EE |  
  | conductor | 3.0 | 0 | sell | EE |  
  | screw | 3.0 | 0 | lend | EE |

  And a user is logged in
  And a user is also an admin

@javascript
Scenario: SID required
  Given I add "capacitor" to cart
  When I click checkout
  Then I should see an alert

@javascript
Scenario: Checkout items
  Given I add "capacitor" to cart
    And I add "resistor" to cart
    And I add "conductor" to cart
  When I enter 234234 as my SID
    And I click checkout
  Then I should be on the items page