Feature: Add item to the inventory

  As an admin
  I want to be able to add products to the inventory
  So that I can sell these items

Background: items have been added to the database

    Given the following items exist:
    | name      | price | quantity | status | type | location_id |
    | capacitor | 4.0   | 5        | Sell   | EE   | 1           | 
    | resistor  | 4.0   | 1        | Sell   | EE   | 1           | 
    | conductor | 3.0   | 0        | Sell   | EE   | 1           | 
    | screw     | 3.0   | 0        | Rent   | EE   | 1           | 

Scenario: add a duplicate item to inventory
    When I add item: capacitor, 3.0, 3, Both, EE, 1
    Then I should see 'duplicate item'

Scenario: add a new item to inventory
    When I add item: led, 4.0, 10, EE, 1
    Then I should see 'successfully added'

Scenario: add a item with invalid price
    When I add item: capacitor, hello , 3, Both, EE, 1
    Then I should see 'invalid price'

Scenario: add a item with invalid quantity
    When I add item: capacitor, 3.75 , -1, Rent, EE, 1
    Then I should see 'invalid quantity'
