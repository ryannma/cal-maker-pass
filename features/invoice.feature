Feature: Viewing invoice

  As the finance manager
  I want to be able to see everyone’s balance
  So that I can invoice people for their purchases

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

Scenario: download invoice csv
  Given I am on the transactions page
  When I export balances
  Then I should receive a file "attachment"

Scenario: download transactions
  Given I am on the transactions page
  When I export transactions
  Then I should receive a file "attachment"

