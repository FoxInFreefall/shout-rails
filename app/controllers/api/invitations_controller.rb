class API::InvitationsController < API::BaseController
  respond_to :json

  def create

    info = params[:invitation]
    print info
    print info[:project_id]
    print info[:email]

    project = Project.find(info[:project_id])
    print project.name

    user = User.find_by_email(info[:email])
    print user

    if user.nil?
      render :json => "{ errors: }", :status=>422
    elsif project.nil?
      render :json => "{ errors: }", :status=>422
    else
      unless project.invites.include?(user)
        project.invites << user
      end
      render :json => project.errors, :status=>201
    end
  end

  # def destroy
  #
  #   project = Project.find(params[:id])
  #   project.destroy
  #
  #   render :json => project.errors, :status=>201
  # end

end
