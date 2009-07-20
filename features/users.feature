Feature: Users must be able to register to the site

In order to allow new users to join the site they need to be able to view the home page & register.
As a guest user
I want to be able to register to the site so that I can create new scenarios for a project

	Scenario: A user must be able to view the welcome page
		Given I am not logged in
		When I visit the home page
		Then I should see the sign up link