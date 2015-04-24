Feature: Add item to the inventory

  As an admin
  I want to be able to add products to the inventory
  So that I can sell these items

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | kind | 
    | capacitor | 4.0 | 5 | sell | EE |  
    | resistor | 4.0 | 1 | sell | EE |  
    | conductor | 3.0 | 0 | sell | EE |  
    | screw | 3.0 | 0 | lend | EE |

    And a user is logged in  

# Scenario: add a duplicate item to inventory
#     When I manually add item: capacitor, 3.0, 3, both, EE
#     Then I should see 'duplicate item'


Scenario: add a new item to inventory
    When I manually add item: ishere, 4.0, 10, sell, EE
    Then I should see "ishere"

Scenario: add a item with invalid price
    When I manually add item: nothere, hello , 3, both, EE
    Then I should not see "nothere"

Scenario: add a item with invalid quantity
    When I manually add item: nothere, 3.75 , hello, lend, EE
    Then I should not see "nothere"

Scenario: add a item with invalid quantity
    When I manually add item: nothere, , 3, lend, EE
    Then I should not see "nothere"


