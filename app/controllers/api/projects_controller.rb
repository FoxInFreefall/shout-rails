class API::ProjectsController < API::BaseController

  def create
    project = Project.create(project_params)

    if project
      project.members << current_user
      respond_with :api, project
    else
      respond_with project.errors, status: 422
    end
  end

  def destroy
    project = Project.find(params[:id])

    if project.members.include?(current_user)
      project.destroy
      render nothing: true, status: 204
    else
      render json: { error: t('errors.forbidden'), message: t('messages.forbidden_modification') }, status: 403
    end


  end

  private

  # This is good for tidying up the params
  def project_params
    params.require(:project).permit(:name)
  end

end