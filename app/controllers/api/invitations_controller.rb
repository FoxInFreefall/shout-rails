class API::InvitationsController < API::BaseController
  respond_to :json

  def create
    project = Project.find(params[:project_id])
    user = User.find_by(invitation_params)

    if project
      if user.nil?
        render json: { error: t('errors.not_found'), message: t('messages.user_not_invitable') }, status: 403
      elsif project.potential_members.include?(user)
        render json: { error: t('errors.redundant'), message: t('messages.user_already_invited') }, status: 200
      elsif current_user.projects.include?(project)
        project.potential_members << user
        render nothing: true, status: 204
      else
        render json: { error: t('errors.forbidden'), message: t('messages.forbidden_modification') }, status: 403
      end
    else
      render json: { error: t('errors.not_found'), message: t('messages.not_found') }, status: 404
    end
  end

  def index
    respond_with current_user.potential_projects, root: "potential_projects"
  end

  def update
    project = Project.find(params[:project_id])
    if project.nil?
      render json: { error: t('errors.not_found'), message: t('messages.not_found') }, status: 404
    elsif project.potential_members.exclude?current_user
      render json: { error: t('errors.declined_access'), message: t('messages.forbidden_join') }, status: 403
    elsif project.members.include?current_user
      render json: { error: t('errors.redundant'), message: t('messages.already_joined') }, status: 200
    else
      project.members<<current_user
      project.potential_members.delete current_user
      render nothing: true, status: 204
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    if project.nil?
      render json: { error: t('errors.not_found'), message: t('messages.not_found') }, status: 404
    elsif project.potential_members.exclude?current_user
      render json: { error: t('errors.declined_access'), message: t('messages.forbidden_decline') }, status: 403
    else
      project.potential_members.delete current_user
      render nothing: true, status: 204
    end
  end

  private

  # This is good for tidying up the params
  def invitation_params
    params.require(:invitation).permit(:email)
  end

end
