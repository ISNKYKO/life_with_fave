class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    if params[:search].present?
      @posts = @posts.joins(:user).where("posts.title LIKE ? OR posts.content LIKE ? OR users.name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: '投稿が削除されました'
  end

  private

  def authenticate_admin!
    redirect_to new_admin_session_path unless current_admin
  end
end
