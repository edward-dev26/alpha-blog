class ApplicationController < ActionController::Base
  helper_method :current_user, :is_auth

  def current_user
    user_id = session[:user_id]
    return nil if user_id.nil?

    @current_user ||= User.find(user_id)
  end

  def is_auth
    !!current_user
  end

  def require_user
    unless is_auth
      flash[:alert] = 'You must by logged in to perform this action'
      redirect_to login_path
    end
  end

  def require_is_not_auth
    if is_auth
      redirect_to user_path(current_user)
    end
  end
end
