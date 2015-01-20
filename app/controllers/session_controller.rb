class SessionController < ApplicationController
  def create
    if Rails.env == 'development' && params[:account] == 'dummy'
      dummy = User.find(1)
      request.env['omniauth.auth'] = {
        provider: dummy.provider,
        uid: dummy.uid
      }
    end
    user = User.find_or_create_by_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'login'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'logout'
  end
end
