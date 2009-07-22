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
  	    @project.stub!(:title).and_return nil
  	    
  	    #@project.stub!(:save).and_return true
  	    post :create
  	  end
  	  
  	  it "should not save the story" do
  	    @project.title.should eql nil
  	    @project.save.should_not eql true
  	  end
      
    end
  end
  
end