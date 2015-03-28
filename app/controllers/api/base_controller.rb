class API::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  respond_to :json

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user = User.find_by_authentication_token(token)
      sign_in user, store: false if user
    end

    # Pass to authenticate_user! filter
    true
  end
end
