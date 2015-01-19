class SessionController < ApplicationController
  def create
    user = User.find_or_create_by_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'login'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'logout'
  end
end
