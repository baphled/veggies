require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController do
  describe "POST, create" do
    before(:each) do
      @project = mock_model(Project,:null_object=>true).as_new_record
      Project.stub!(:new).and_return @project
    end
    context "a valid project" do
      before(:each) do
        @project.stub!(:save).and_return true
        post :create
      end
      
      it "should save" do
        @project.save.should eql true
      end
      it "should display a success flash message" do
        flash.should contain "You have successfully created your new project"
      end
    end
    
  	context "an invalid project" do
  	  before(:each) do
  	    @project.stub!(:save).and_return false
  	    post :create
  	  end
  	  
  	  it "should not save the story" do
  	    @project.save.should eql false
  	  end
      
    end
  end
  
end