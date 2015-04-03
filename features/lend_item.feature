Feature: Lend an item
  
  As an admin
  I want to see a list of students and components
  So I can lend items to students

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | type | location_id|
    | capacitor | 4.0 | 5 | Sell | EE | 1 | 
    | resistor | 4.0 | 1 | Both | EE | 1 |
    | conductor | 3.0 | 0 | Sell | EE | 1 | 
    | screw | 3.0 | 0 | Rent | EE | 1 | 

    Given the following users exist:
    | first_name | last_name | sid | location_id |
    | John | Doe | 12345678 | 1 |
    | Jane | Smith | 23456789 | 2 |

Scenario: an admin lends to a user an item that is out of inventory

Scenario: an admin lends to a user an item that is only for sale

Scenario: an admin lends to a user an item from a location not accessible to that user

Scenario: an admin lends to a user an item
