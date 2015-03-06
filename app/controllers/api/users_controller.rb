class Api::UsersController < ApplicationController

  # skip_before_filter :verify_authenticity_token
  respond_to :json

  def create

    user = User.new(user_params)

    if user.save
      render :json => user.errors, :status=>201
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  def index

    user = User.find_by_email(params[:email])

    if user
      render :json => user.errors, :status=>201
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
