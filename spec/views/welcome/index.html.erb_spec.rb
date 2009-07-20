require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/welcome/index" do
  context "viewing as a unregistered user" do
    before(:each) do
      render
    end
    it "should have a sign up link" do
      response.should have_selector("a", :content => "Sign up")
    end

    it "should not have a new project link" do
      response.should_not have_selector("a", :content => "New Project")
    end
  end

  context "viewing as a registered user" do
    before(:each) do
      template.stub!(:current_user).and_return mock_model(User)
      render
    end
    it "should be able to see the new project link" do
      response.should have_selector("a", :content => "New Project")
    end
  end
end
