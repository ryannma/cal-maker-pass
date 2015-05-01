Feature: Add item to cart

  As an admin
  I want to add items that I wish to lend or sell to a cart
  So that I can preview all my items before checking 

Background: items have been added to the database
  
  Given the following items exist:
  | name | price | quantity | status | kind | 
  | capacitor | 4.0 | 5 | sell | EE |  
  | resistor | 4.0 | 1 | sell | EE |  
  | conductor | 3.0 | 0 | sell | EE |  
  | screw | 3.0 | 0 | lend | EE |

  And a user is logged in

@javascript
Scenario: add an item to cart
  When I add "capacitor" to cart
  Then I should see "capacitor" in cart

@javascript
Scenario: remove an item from cart
  Given I add "capacitor" to cart
  And I add "resistor" to cart
  When I remove "capacitor" from cart
  Then I should not see "capacitor" in cart
