Feature: Sorting the inventory

  As an admin
  I would like to be able to sort the inventory by each column
  So that I can better navigate through the stock

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | kind | 
    | capacitor | 4.0 | 5 | sell | EE |  
    | resistor | 4.0 | 1 | sell | EE |  
    | conductor | 3.0 | 0 | sell | EE |  
    | screw | 3.0 | 0 | lend | EE |

    And a user is logged in  

Scenario: items are sortable
  Given I go to the items page
  When I sort items by name
    And I sort items by quantity
    And I sort items by price
    And I sort items by kind
    And I sort items by status
  Then I should see "capacitor"
    And I should see "resistor"
    And I should be on the items page