Feature: Pagination

  As a user
  I want to be able to see a paginated inventory
  So that it is easy to find and look around the inventory

Background:
 
  Given the following items exist:
  | name | price | quantity | status | kind | 
  | itemA | 4.0 | 5 | sell | EE |  
  | itemB | 4.0 | 1 | sell | EE |  
  | itemC | 3.0 | 0 | sell | EE |  
  | itemD | 3.0 | 0 | lend | EE |
  | itemE | 4.0 | 5 | sell | EE |  
  | itemF | 4.0 | 5 | sell | EE |  
  | itemG | 4.0 | 1 | sell | EE |  
  | itemH | 3.0 | 0 | sell | EE |  
  | itemI | 3.0 | 0 | lend | EE |
  | itemJ | 4.0 | 5 | sell | EE |
  | itemK | 4.0 | 5 | sell | EE |  
  | itemL | 4.0 | 1 | sell | EE |  
  | itemM | 3.0 | 0 | sell | EE |  
  | itemN | 3.0 | 0 | lend | EE |
  | itemO | 4.0 | 5 | sell | EE |
  | itemP | 4.0 | 5 | sell | EE |  
  | itemQ | 4.0 | 1 | sell | EE |  
  | itemR | 3.0 | 0 | sell | EE |  
  | itemS | 3.0 | 0 | lend | EE |
  | itemT | 4.0 | 5 | sell | EE |
  | itemU | 4.0 | 5 | sell | EE |
  | itemV | 4.0 | 5 | sell | EE |

  And a user is logged in 

@javascript
Scenario: I should see first items only
  Given I am on the items page
  Then I should see "itemA"
    And I should see "itemL"
    And I should see "itemT"
    And I should not see "itemU"

Scenario: I should see other items on next page
  Given I am on the items page
  When I click next page
  Then I should see "itemV"
    And I should not see "itemA"
