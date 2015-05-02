Feature: Search for items

  As an admin
  I would like to search items
  So that I can edit, delete or sell them

Background: items have been added to the database

    Given the following items exist:
    | name | price | quantity | status | kind |
    | item1 | 4.0 | 5 | sell | EE | 
    | item2 | 4.0 | 5 | sell | EE | 
    | item3 | 3.0 | 0 | sell | EE |  
    | item4 | 3.0 | 0 | lend | EE |
    | item5 | 4.0 | 5 | sell | EE |  
    | item6 | 4.0 | 5 | sell | EE |  
    | item7 | 4.0 | 1 | sell | EE |  
    | item8 | 3.0 | 0 | sell | EE |  
    | item9 | 3.0 | 0 | lend | EE |
    | item10 | 4.0 | 5 | sell | EE |
    | item11 | 4.0 | 5 | sell | EE |  
    | item12 | 4.0 | 1 | sell | EE |  
    | item13 | 3.0 | 0 | sell | EE |  
    | item14 | 3.0 | 0 | lend | EE |
    | item15 | 4.0 | 5 | sell | EE |
    | item16 | 4.0 | 5 | sell | EE |  
    | item17 | 4.0 | 1 | sell | EE |  
    | item18 | 3.0 | 0 | sell | EE |  
    | item19 | 3.0 | 0 | lend | EE |
    | item20 | 4.0 | 5 | sell | EE |
    | item21 | 4.0 | 5 | sell | EE |
    | specitem22 | 4.0 | 5 | sell | EE | 

    And a user is logged in  

#Scenario: search an item without pressing enter
    #When I fill in "phrase" with "spec"
    #Then I should see "specitem22"


