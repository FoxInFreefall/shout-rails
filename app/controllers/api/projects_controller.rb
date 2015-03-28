class API::ProjectsController < API::BaseController
  def create

    project = Project.new(project_params)

    if project.save
      render :json => "{ id: " + project.id.to_s + " }", :status=>201
    else
      warden.custom_failure!
      render :json => project.errors, :status=>422
    end
  end

  def destroy

    project = Project.find(params[:id])
    project.destroy

    render :json => project.errors, :status=>201
  end

  def project_params
    params.require(:project).permit(:name)
  end

end