Feature: As a registered user I must be able to create projects
	  In order to create a new project I must be logged in
	  As a registered user
	  I want I want to be able to create new projects

		Scenario: A registered user must be able to create projects
		  Given an activated user named 'reggie'
		  When I click new project
			And fill in the new project form
		  Then I should get confirmation of the successful creation