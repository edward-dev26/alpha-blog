module AuthHelper
  def current_user
    user_id = session[:user_id]
    return nil if user_id.nil?

    @current_user ||= User.find(user_id)
  end

  def is_auth
    !!current_user
  end
end
