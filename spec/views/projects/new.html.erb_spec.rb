require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/new.html.erb" do

  it "should have a form" do
		@project = mock_model(Project,:null_object=>true)
    assigns[:project] = @project
    render
    response.should have_tag("form[action=/projects][method=post]") do
      with_tag('input#project_title[name=?]', "project[title]")
      with_tag('textarea#project_description[name=?]', "project[description]")
      with_tag('textarea#project_aim[name=?]', "project[aim]")
    end
  end
end
