class API::AssignmentsController < API::BaseController
  respond_to :json

  def create
    project = Project.find(params[:project_id])
    task = Task.find(params[:task_id])
    user = User.find_by(assignment_params)

    if project.nil? || task.nil? || user.nil?
      render json: { error: t('errors.not_found'), message: t('messages.not_found') }, status: 404
    elsif project.members.exclude?(current_user)
      render json: { error: t('errors.forbidden'), message: t('messages.forbidden_modification') }, status: 403
    elsif project.tasks.exclude?(task)
      render json: { error: t('errors.data_mismatch'), message: t('messages.task_project_mismatch') }, status: 403
    elsif project.members.exclude?(user)
      render json: { error: t('errors.declined_access'), message: t('messages.user_not_apart') }, status: 403
    elsif task.members.include?(user)
      render json: { error: t('errors.redundant'), message: t('messages.user_already_on_task') }, status: 403
    else
      task.members << user
      render nothing: true, status: 204
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    task = Task.find(params[:task_id])
    user = User.find(params[:user_id])

    if project.nil? || task.nil? || user.nil?
      render json: { error: t('errors.not_found'), message: t('messages.not_found') }, status: 404
    elsif project.members.exclude?(current_user)
      render json: { error: t('errors.forbidden'), message: t('messages.forbidden_modification') }, status: 403
    elsif project.members.exclude?(user)
      render json: { error: t('errors.declined_access'), message: t('messages.user_not_apart') }, status: 403
    elsif task.members.exclude?(user)
      render json: { error: t('errors.pointless'), message: t('messages.pointless_unjoin_task') }, status: 200
    else
      task.members.delete(user)
      render nothing: true, status: 204
    end
  end

  private

  # This is good for tidying up the params
  def assignment_params
    params.require(:user).permit(:id)
  end

end
