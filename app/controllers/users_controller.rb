class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_is_not_auth, only: [:create]
  before_action :require_user, only: [:edit, :update]
  before_action :require_owner, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(get_user_data)

    if @user.save
      flash[:notice] = "Hi, #{@user.username}. Welcome to Ruby Blog!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'signup'
    end
  end

  def edit
  end

  def update
    if @user.update(get_user_data)
      flash[:notice] = "Your profile successfully updated!"

      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def get_user_data
    params.require(:user).permit(:username, :email, :password)
  end

  def require_owner
    if @user != current_user
      flash[:alert] = 'You can edit or delete only own profile'
      redirect_to user_path(@user)
    end
  end
end