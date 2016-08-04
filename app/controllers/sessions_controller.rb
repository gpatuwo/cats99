class SessionsController < ApplicationController
  before_action :redirect_if_signed_in!, only: [:create, :new]

  def create
    login!
  end

  def new

  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to cats_url
  end

  private
  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
