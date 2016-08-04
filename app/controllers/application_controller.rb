class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper_method exposes method to the views
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    return false unless current_user
    session[:session_token] == current_user.session_token
  end

  def redirect_if_signed_in!
    redirect_to cats_url if logged_in?
  end

  def login!
    @user = User.find_by_credentials(
      app_params[:user_name],
      app_params[:password])

    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    end
  end

  def logout!
  end

  def is_owner?
    current_user.is_owner?(params[:id])
  end

  def redirect_unless_owner!
    unless is_owner?
      flash[:errors] = "You can't edit another owner's cats, silly!"
      redirect_to cats_url
    end
  end

  private
  def app_params
    params.require(:user).permit(:user_name, :password)
  end


end
