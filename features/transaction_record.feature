Feature: Record of transactions

  As an admin
  I would like to be able to see a record of past transactions
  So that I can bill parties accordingly

Background: items have been added to the database
  
  Given the following items exist:
  | name | price | quantity | status | kind | 
  | capacitor | 4.0 | 5 | sell | EE |  
  | resistor | 4.0 | 1 | sell | EE |  
  | conductor | 3.0 | 0 | sell | EE |  
  | screw | 3.0 | 0 | lend | EE |

    And a user is logged in
    And a user is also an admin
    And the following transaction exists:
    | capacitor | 1.0 | sold |
    | resistor | 1.0 | sold |
    And the following transaction exists:
    | conductor | 2.0 | lend |
    | screw | 5.0 | sold |

Scenario: see list of transactions
  When I go to the transactions page
    And I click all
  Then I should see 2 transactions

Scenario: view transaction details
  Given I go to the transactions page
    And I click all
  When I click transaction 1
  Then I should be on the detail page for transaction 1

Scenario: view own sales
  Given I go to the transactions page
  When I click own
  Then I should see 2 transactions

Scenario: transactions are sortable
  Given I go to the transactions page
  When I sort transactions by date
    And I sort transactions by customer
    And I sort transactions by purpose
  Then I should see 2 transactions

@javascript
Scenario: transactions on all view are sortable by all
  Given I go to the transactions page
    And I click all
  When I sort transactions by date
    And I sort transactions by customer
    And I sort transactions by purpose
  Then I should see 2 transactions

@javascript
Scenario: transactions on all view are sortable by own
  Given I go to the transactions page
    And I click own
  When I sort transactions by date
    And I sort transactions by customer
    And I sort transactions by purpose
  Then I should see 2 transactions



