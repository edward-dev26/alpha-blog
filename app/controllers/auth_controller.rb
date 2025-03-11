class AuthController < ApplicationController
  before_action :require_is_not_auth, only: [:signup, :login, :signin]

  def signup
    @user = User.new
  end

  def login
  end

  def signin
    email = params[:auth][:email].downcase
    password = params[:auth][:password]
    user = User.find_by(email: email)

    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:alert] = 'Invalid email or password'

      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end
end