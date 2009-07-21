Feature: As a registered user I must be able to create projects
	  In order to create a new project I must be logged in
	  As a registered user
	  I want I want to be able to create new projects

		Scenario: A registered user must be able to create projects
		  Given an activated user logged in as 'reggie'
		  When I visit the home page
			And I click new project
			And fill in the new project form
		  Then I should get confirmation of the successful creation
	
		Scenario: When submitting the form the user must be alerted if the title is not present
	  	Given an activated user logged in as 'reggie'
		  When I visit the home page
			And I click new project
			And fill in the new project form without a title
			And submit the form
		  Then a validation message will be displayed say 'Title can't be blank'
		
		Scenario: When submitting the form the user must be alerted if the description is not present
	  	Given an activated user logged in as 'reggie'
		  When I visit the home page
			And I click new project
			And fill in the new project form without a description
			And submit the form
		  Then a validation message will be displayed say 'Description can't be blank'
		
		Scenario: When submitting the form the user must be alerted if the aim is not present
	  	Given an activated user logged in as 'reggie'
		  When I visit the home page
			And I click new project
			And fill in the new project form without a aim
			And submit the form
		  Then a validation message will be displayed say 'Aim can't be blank'