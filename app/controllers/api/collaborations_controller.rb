class API::CollaborationsController < API::BaseController

  def destroy
    project = Project.find(params[:project_id])

    if project.members.include?(current_user)
      project.members.delete(current_user)

      if project.members.empty?
        project.destroy
      end

      render nothing: true, status: 204
    else
      render json: { error: t('errors.pointless'), message: t('messages.pointless_abandonment') }, status: 403
    end
  end

end