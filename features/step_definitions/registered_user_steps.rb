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