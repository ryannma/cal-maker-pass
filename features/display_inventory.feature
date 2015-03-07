Feature: Display list of items

  As an admin
  I want to see all the items in my inventory
  So that I can know what items we carry when students ask what we have

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | type | location_id|
    | capacitor | 4.0 | 5 | Sell | EE | 1 | 
    | resistor | 4.0 | 1 | Sell | EE | 1 | 
    | conductor | 3.0 | 0 | Sell | EE | 1 | 
    | screw | 3.0 | 0 | Rent | EE | 1 | 

    And I am on the inventory page

Scenario: find item with name
    When I search 'capacitor'
    Then I should see 'capacitor'
    And I should not see 'resistor'

Scenario: can't find item with name
    When I search 'cable'
    Then I should see 'item not found'

