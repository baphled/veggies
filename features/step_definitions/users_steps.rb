Given /^I am not logged in$/ do
end

When /^I visit the home page$/ do
  visit '/'
end

Then /^I should see the sign up link$/ do
  response.should contain 'Sign up'
end
