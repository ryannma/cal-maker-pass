Feature: Remove item from the inventory
  
  As an admin
  I want to be able to remove products from the inventory
  So that I can no longer sell these products

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | type | location_id|
    | capacitor | 4.0 | 5 | Sell | EE | 1 | 
    | resistor | 4.0 | 1 | Sell | EE | 1 | 
    | conductor | 3.0 | 0 | Sell | EE | 1 | 
    | screw | 3.0 | 0 | Rent | EE | 1 | 

    And I am on the show 'capacitor' page

Scenario: delete an item from the item page
    When I press 'Delete'
    Then I should be on the inventory page
    And I should not see 'capacitor'