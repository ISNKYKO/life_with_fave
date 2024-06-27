class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:show, :index, :edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
  def index
    @users =User.all
  end


  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(current_user_path) unless current_user?(@user)
  end

  def current_user?(user)
    user == current_user
  end

  def current_user_path
    user_path(current_user)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
end
