class Public::FavoritesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_post
  
  def create
    @post.favorites.create(user: current_user)
    redirect_to post_path(@post)
  end

  def destroy
    @post.favorites.find_by(user: current_user).destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
