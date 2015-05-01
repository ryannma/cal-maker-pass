Feature: Remove item from cart

  As an admin
  I want to remove items from my cart
  So that I will have the correct items that I want to check out

Background: items have been added to the database
  
  Given the following items exist:
  | name | price | quantity | status | kind | 
  | capacitor | 4.0 | 5 | sell | EE |  
  | resistor | 4.0 | 1 | sell | EE |  
  | conductor | 3.0 | 0 | sell | EE |  
  | screw | 3.0 | 0 | lend | EE |

  And a user is logged in

@javascript
Scenario: remove an item from cart
  Given I add "capacitor" to cart
    And I add "resistor" to cart
  When I remove "capacitor" from cart
  Then I should not see "capacitor" in cart