Feature: Search for items

  As an admin
  I would like to search items
  So that I can edit, delete or sell them

Background: items have been added to the database

  Given the following items exist:
  | name | price | quantity | status | kind | 
  | capacitor | 4.0 | 5 | sell | EE |  
  | resistor | 4.0 | 1 | sell | EE |  
  | conductor | 3.0 | 0 | sell | EE |  
  | screw | 3.0 | 0 | lend | EE |

  And a user is logged in  

Scenario: search an item
  Given I am on the items path
  When I search for "capacitor"
  #When I fill in "phrase" with "spec"
  #Then I should see "specitem22"


