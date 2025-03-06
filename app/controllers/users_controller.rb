class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_user_data)

    if @user.save
      flash[:notice] = "Hi, #{@user.username}. Welcome to Ruby Blog!"

      redirect_to user_path(@user)
    else
      render 'new'
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
end