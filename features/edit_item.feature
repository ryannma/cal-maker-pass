Feature: Add item to the inventory

  As an admin
  I want to be able to edit exisiting products
  So that I can keep the inventory accurate

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | kind | 
    | capacitor | 4.0 | 5 | sell | EE |  
    | resistor | 4.0 | 1 | sell | EE |  
    | conductor | 3.0 | 0 | sell | EE |  
    | screw | 3.0 | 0 | lend | EE |

    And a user is logged in  

@javascript
Scenario: changing an item's name
    When I edit Name of capacitor to Fiberboard
    Then I should see "Fiberboard"

@javascript
Scenario: deleting an item
    Given I see details of capacitor
    When I delete capacitor
    Then I should not see "capacitor"
