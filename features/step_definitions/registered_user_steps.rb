When /^I click new project$/ do
	 visit "/projects/new"
end

When /^fill in the new project form$/ do
  fill_in 'project_title', :with => 'new project'
  fill_in 'project_description', :with => 'This project will help us manage stuff'
  fill_in 'project_aim', :with => 'To provide a service'
  submit_form 'new_project'
end

Then /^I should get confirmation of the successful creation$/ do
  flash.should contain "You have successfully created your new project"
end

When /^fill in the new project form without a title$/ do
  fill_in 'project_description', :with => 'This project will help us manage stuff'
  fill_in 'project_aim', :with => 'To provide a service'
end

When /^fill in the new project form without a description$/ do
  fill_in 'project_title', :with => 'new project'
  fill_in 'project_aim', :with => 'To provide a service'
end

When /^fill in the new project form without a aim$/ do
  fill_in 'project_title', :with => 'new project'
  fill_in 'project_description', :with => 'This project will help us manage stuff'
end

When /^submit the form$/ do
  submit_form 'new_project'
end

Then /^a validation message will be displayed say '(.*)'$/ do |message|
  response.should have_selector :li, :content => message
end

