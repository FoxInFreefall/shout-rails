class API::SessionsController < API::BaseController
  skip_before_filter :authenticate_user!

  def create
    request.env['devise.allow_params_authentication'] = true

    user = warden.authenticate!(scope: :user)

    if user
      respond_with :api, user
    else
      render json: { error: :invalid_credentials, message: t('errors.invalid_credentials') }, status: 401
    end
  end
end