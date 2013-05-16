Feature: A music fan searches for articles 

	As a music fan
	I want to read biographical info about an artist 

	Scenario: A music fan searches for an article by title 
		Given a fascinating article about "Searching with Sphinx"
			And assuming the Sphinx index is up to date
			And I am on the homepage 
		When I search for "Sphinx"
			Then I should see an article about "Searching with Sphinx"