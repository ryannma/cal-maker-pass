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

