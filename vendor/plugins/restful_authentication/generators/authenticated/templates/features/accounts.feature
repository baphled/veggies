Visitors should be in control of creating an account and of proving their
essential humanity/accountability or whatever it is people think the
id-validation does.  We should be fairly skeptical about this process, as the
identity+trust chain starts here.

Story: Creating an account
  As an anonymous user
  I want to be able to create an account
  So that I can be one of the cool kids

  #
  # Account Creation: Get entry form
  #
  Scenario: Anonymous user can start creating an account
    Given an anonymous user
    When  she goes to /signup
    Then  she should be at the 'users/new' page
     And  the page should look AWESOME
<% if options[:email_only] -%>
     And  she should see a <form> containing a textfield: Email, password: Password, password: 'Confirm Password', submit: 'Sign up'
<% else -%>
     And  she should see a <form> containing a textfield: Login, textfield: Email, password: Password, password: 'Confirm Password', submit: 'Sign up'
<% end -%>

  #
  # Account Creation
  #
  Scenario: Anonymous user can create an account
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
<% else -%>
     And  no user with login: 'Oona' exists
<% end -%>
    When  she registers an account as the preloaded 'Oona'
    Then  she should be redirected to the home page
    When  she follows that redirect!
    Then  she should see a notice message 'Thanks for signing up!'
<% if options[:email_only] -%>
     And  a user with email: 'oona@example.com' should exist
<% else -%>
     And  a user with login: 'oona' should exist
     And  the user should have login: 'oona', and email: 'oona@example.com'
<% end -%>
<% if options[:include_activation] -%>
     And  an email should be sent to 'oona@example.com' with the activation code for oona
     And  oona should not be logged in
<% else -%>
     And  oona should be logged in
<% end -%>

  #
  # Account Creation Failure: Account exists
  #
  Scenario: Anonymous user can not create an account replacing an activated account
    Given an anonymous user
     And  an activated user named 'Reggie'
     And  we try hard to remember the user's updated_at, and created_at
<% if options[:email_only] -%>
    When  she registers an account with email: 'registered@example.com' and password: 'monkey'
    Then  she should be at the 'users/new' page
     And  she should see an errorExplanation message 'Email has already been taken'
     And  a user with email: 'registered@example.com' should exist
<% else -%>
    When  she registers an account with login: 'reggie', password: 'monkey', and email: 'reggie@example.com'
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Login has already been taken'
     And  she should not see an errorExplanation message 'Email has already been taken'
     And  a user with login: 'reggie' should exist
     And  the user should have email: 'registered@example.com'
<% end -%>
     And  the user's created_at should stay the same under to_s
     And  the user's updated_at should stay the same under to_s
     And  she should not be logged in

  #
  # Account Creation Failure: Incomplete input
  #
<% unless options[:email_only] -%>
  Scenario: Anonymous user can not create an account with incomplete or incorrect input
    Given an anonymous user
     And  no user with login: 'Oona' exists
    When  she registers an account with login: '', password: 'monkey', password_confirmation: 'monkey' and email: 'oona@example.com'
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Login can't be blank'
     And  no user with login: 'oona' should exist
<% end -%>

  Scenario: Anonymous user can not create an account with no password
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
    When  she registers an account with email: 'oona@example.com', password: '', and password_confirmation: 'monkey'
    Then  she should be at the 'users/new' page
     And  she should see an errorExplanation message 'Password can't be blank'
     And  no user with email: 'oona@example.com' should exist
<% else -%>
     And  no user with login: 'Oona' exists
    When  she registers an account with login: 'oona', password: '', password_confirmation: 'monkey' and email: 'oona@example.com'
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Password can't be blank'
     And  no user with login: 'oona' should exist
<% end -%>

  Scenario: Anonymous user can not create an account with no password_confirmation
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
    When  she registers an account with email: 'oona@example.com', password: 'monkey', and password_confirmation: ''
    Then  she should be at the 'users/new' page
     And  she should see an errorExplanation message 'Password confirmation can't be blank'
     And  no user with email: 'oona@example.com' should exist
<% else -%>
     And  no user with login: 'Oona' exists
    When  she registers an account with login: 'oona', password: 'monkey', password_confirmation: '' and email: 'oona@example.com'
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Password confirmation can't be blank'
     And  no user with login: 'oona' should exist
<% end -%>

  Scenario: Anonymous user can not create an account with mismatched password & password_confirmation
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
    When  she registers an account with email: 'oona@example.com', password: 'monkey', and password_confirmation: 'monkeY'
    Then  she should be at the 'users/new' page
     And  she should see an errorExplanation message 'Password doesn't match confirmation'
     And  no user with email: 'oona@example.com' should exist
<% else -%>
     And  no user with login: 'Oona' exists
    When  she registers an account with login: 'oona', password: 'monkey', password_confirmation: 'monkeY' and email: 'oona@example.com'
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Password doesn't match confirmation'
     And  no user with login: 'oona' should exist
<% end -%>

  Scenario: Anonymous user can not create an account with bad email
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
    When  she registers an account with email: '', password: 'monkey', and password_confirmation: 'monkey'
    Then  she should be at the 'users/new' page
     And  she should see an errorExplanation message 'Email can't be blank'
     And  no user with email: 'oona@example.com' should exist
    When  she registers an account with email: 'oona@example.com', password: 'monkey' and password_confirmation: 'monkey'
    Then  she should be redirected to the home page
    When  she follows that redirect!
    Then  she should see a notice message 'Thanks for signing up!'
     And  a user with email: 'oona@example.com' should exist
<% else -%>
     And  no user with login: 'Oona' exists
    When  she registers an account with login: 'oona', password: 'monkey', password_confirmation: 'monkey' and email: ''
    Then  she should be at the 'users/new' page
     And  she should     see an errorExplanation message 'Email can't be blank'
     And  no user with login: 'oona' should exist
    When  she registers an account with login: 'oona', password: 'monkey', password_confirmation: 'monkey' and email: 'oona@example.com'
    Then  she should be redirected to the home page
    When  she follows that redirect!
    Then  she should see a notice message 'Thanks for signing up!'
     And  a user with login: 'oona' should exist
     And  the user should have login: 'oona', and email: 'oona@example.com'
<% end -%>
<% if options[:include_activation] -%>
     And  an email should be sent to 'oona@example.com' with the activation code for oona
     And  oona should not be logged in
<% else -%>
     And  oona should be logged in
<% end -%>

<% if options[:include_activation] -%>
  #
  # Account Activation
  #
  Scenario: Activate an account successfully
    Given an anonymous user
<% if options[:email_only] -%>
     And  no user with email: 'oona@example.com' exists
    When  she registers an account as the preloaded 'Oona'
    Then  she should be redirected to the home page
    When  she follows that redirect!
    Then  she should see a notice message 'Thanks for signing up!'
     And  a user with email: 'oona@example.com' should exist
     And  an email should be sent to 'oona@example.com' with the activation code for oona
     And  oona should not be logged in
    When  oona goes to her activation url
    Then  she should be redirected to '/login'
    When  she follows that redirect!
    Then  she should see a notice message 'Signup complete!'
     And  oona should not be logged in
     And  a user with email: 'oona@example.com' should exist
     And  the user should have state: 'active'
<% else -%>
     And  no user with login: 'Oona' exists
    When  she registers an account as the preloaded 'Oona'
    Then  she should be redirected to the home page
    When  she follows that redirect!
    Then  she should see a notice message 'Thanks for signing up!'
     And  a user with login: 'oona' should exist
     And  the user should have login: 'oona', and email: 'oona@example.com'
     And  an email should be sent to 'oona@example.com' with the activation code for oona
     And  oona should not be logged in
    When  oona goes to her activation url
    Then  she should be redirected to '/login'
    When  she follows that redirect!
    Then  she should see a notice message 'Signup complete!'
     And  oona should not be logged in
     And  a user with login: 'oona' should exist
     And  the user should have state: 'active'
<% end -%>

  Scenario: Attmepting to activate an account with a bogus activation receives an error
    Given an anonymous user
     When she goes to /activate/this_is_a_bogus_activation_code
     Then she should be redirected to the home page
     When she follows that redirect!
     Then she should see an error message 'check your email'
      And she should not be logged in
<% end -%>
