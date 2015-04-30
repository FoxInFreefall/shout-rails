class API::TasksController < API::BaseController

  def create
    project = Project.find(params[:project_id])

    task = Task.create(task_params)

    if project && task
      task.project = project

      respond_with :api, task
    else
      respond_with task.errors, status: 422
    end

    render nothing: true
  end

  # def destroy
  #   task = Project.find(params[:id])
  #
  #   if task.members.include?(current_user)
  #     task.destroy
  #     render nothing: true, status: 204
  #   else
  #     render json: { error: t('errors.forbidden'), message: t('messages.forbidden_modification') }, status: 403
  #   end
  #
  #
  # end

  private

  # This is good for tidying up the params
  def task_params
    params.require(:task).permit(:title, :description)
  end

end