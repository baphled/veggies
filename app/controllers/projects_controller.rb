class ProjectsController < ActionController::Base
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = "You have successfully created your new project"
        format.html { redirect_to projects_path @project }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
    end
  end
end