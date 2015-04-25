Feature: Authenticate a user via calnet

	As a user
	I want to be able to log in to the system via Cal net authentication
	So that I can easily have an account on the Maker Pass system

Background

Scenario: end up on sign in page after calnet login

	Given a user is calnet logged in
	When I go to the items page
	Then I should see "First Name"
	And I should not see "Item"

Scenario: bypass sign in page if already a user

	Given a user is logged in
	When I go to the items page
	Then I should not see "Sign Up"
	Then I should see "Inventory"


