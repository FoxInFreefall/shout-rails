class API::UsersController < API::BaseController
  skip_before_filter :authenticate_user!

  def create
    user = User.create(user_params)
    respond_with :api, user, serializer: UserLoginSerializer
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
