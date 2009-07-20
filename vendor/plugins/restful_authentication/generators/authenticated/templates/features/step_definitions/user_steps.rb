RE_User      = %r{(?:(?:the )? *(\w+) *)}
RE_User_TYPE = %r{(?: *(\w+)? *)}

#
# Setting
#

Given "an anonymous user" do
  log_out!
end

Given "$an $user_type user with $attributes" do |_, user_type, attributes|
  create_user! user_type, attributes.to_hash_from_story
end

Given "an $user_type user named '$name'" do |user_type, name|
  create_user! user_type, named_user(name)
end

Given "$an $user_type user logged in as '$name'" do |_, user_type, name|
  create_user! user_type, named_user(name)
  log_in_user!
end

#Given "$actor is logged in" do |_, login|
#  log_in_user! @user_params || named_user(login)
#end

Given "there is no $user_type user named '$login'" do |_, login|
  @user = User.find_by_login(login)
  @user.destroy! if @user
  @user.should be_nil
end

#
# Actions
#
When "$actor logs out" do
  log_out
end

When "$actor registers an account as the preloaded '$name'" do |_, name|
  user = named_user(name)
  user['password_confirmation'] = user['password']
  create_user user
end

When "$actor registers an account with $attributes" do |_, attributes|
  create_user attributes.to_hash_from_story
end


When "$actor logs in with $attributes" do |_, attributes|
  log_in_user attributes.to_hash_from_story
end

#
# Result
#
Then "$actor should be invited to sign in" do |_|
  response.should render_template('/sessions/new')
end

Then "$actor should not be logged in" do |_|
  controller.logged_in?.should_not be_true
end

Then "$login should be logged in" do |name|
  controller.logged_in?.should be_true
  controller.current_user.should === @user
  user = named_user_instance(name)
  controller.current_user.should == user
end

<% if options[:include_activation] -%>
Then "an email should be sent to '$address' with the activation code for $name" do |address, name|
  response.should send_email
  email = ActionMailer::Base.deliveries[0]
  email.to.should include(address)
  email.body.should include(named_user_instance(name).activation_code)
end
<% end -%>

def named_user login
  user_params = {
    'admin'   => {'id' => 1, 'login' => 'addie', 'password' => '1234addie', 'email' => 'admin@example.com',       },
    'oona'    => {          'login' => 'oona',   'password' => '1234oona',  'email' => 'oona@example.com'},
    'reggie'  => {          'login' => 'reggie', 'password' => 'monkey',    'email' => 'registered@example.com' },
    }
  user_params[login.downcase]
end

# Lookup the named user in the database
def named_user_instance(name)
  user = named_user(name)
  <% if options[:email_only] -%>
  User.find_by_email(user['email'])
<% else -%>
  User.find_by_login(user['login'])
<% end -%> 
end

#
# User account actions.
#
# The ! methods are 'just get the job done'.  It's true, they do some testing of
# their own -- thus un-DRY'ing tests that do and should live in the user account
# stories -- but the repetition is ultimately important so that a faulty test setup
# fails early.
#

def log_out
  get '/sessions/destroy'
end

def log_out!
  log_out
  response.should redirect_to('/')
  follow_redirect!
end

def create_user(user_params={})
  @user_params       ||= user_params
  post "/users", :user => user_params
<% if options[:email_only] -%>
  @user = User.find_by_email(user_params['email'])
<% else -%>
  @user = User.find_by_login(user_params['login'])
<% end -%>
end

def create_user!(user_type, user_params)
  user_params['password_confirmation'] ||= user_params['password'] ||= user_params['password']
  create_user user_params
  response.should redirect_to('/')
  follow_redirect!
<% if options[:include_activation] -%>
  if user_type == 'activated'
<% if options[:email_only] -%>
    user = User.find_by_email(user_params['email'])
<% else -%>
    user = User.find_by_login(user_params['login'])
<% end -%>
    get "/activate/#{user.activation_code}"
    response.should redirect_to('/login')
    follow_redirect!
  end
<% end -%>
end



def log_in_user user_params=nil
  @user_params ||= user_params
  user_params  ||= @user_params
  post "/session", user_params
<% if options[:email_only] -%>
    @user = User.find_by_email(user_params['email'])
<% else -%>
    @user = User.find_by_login(user_params['login'])
<% end -%>  controller.current_user
end

def log_in_user! *args
  log_in_user *args
  response.should redirect_to('/')
  follow_redirect!
  response.should have_flash("notice", /Logged in successfully/)
end
