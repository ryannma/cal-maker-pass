Feature: Lend an item
  
  As an admin
  I want to see a list of students and components
  So I can lend items to students

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | type | location_id|
    | capacitor | 4.0 | 5 | Sell | EE | 1 |
    | resistor | 4.0 | 5 | Both | EE | 1 |
    | inductor | 4.0 | 5 | Rent | EE | 1 |
    | conductor | 3.0 | 0 | Sell | EE | 1 |
    | led | 3.0 | 0 | Both | EE | 1 |
    | screw | 3.0 | 0 | Rent | EE | 1 |

Scenario: rent an item with status 'Sell' with non-zero quantity
    When I rent item: capacitor, 4.0, 5, Sell, EE, 1
    Then I should see 'cannot lend'

Scenario: rent an item with status 'Both' with non-zero quantity
    When I rent item: resistor, 4.0, 5, Both, EE, 1
    Then I should see 'successfully lent'

Scenario: rent an item with status 'Rent' with non-zero quantity
    When I rent item: inductor, 4.0, 5, Rent, EE, 1
    Then I should see 'successfully lent'

Scenario: rent an item with status 'Sell' with zero quantity
    When I rent item: conductor, 3.0, 0, Sell, EE, 1
    Then I should see 'cannot lend'

Scenario: rent an item with status 'Both' with zero quantity
    When I rent item: led, 3.0, 0, Both, EE, 1
    Then I should see 'out of stock'

Scenario: rent an item with status 'Rent' with zero quantity
    When I rent item: screw, 3.0, 0, Rent, EE, 1
    Then I should see 'out of stock'
