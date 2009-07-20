class ProjectsController < ActionController::Base
  def new
    @project = Project.new
  end
  
  def create
    flash[:notice] = "You have successfully created your new project"
    redirect_to('/')
  end
end