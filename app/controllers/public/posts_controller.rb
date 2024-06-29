class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :update]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
     redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts =Post.all
    @q = Post.ransack(params[:q])
    @posts = @q.result
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end
  
private
  
def authenticate_user
  redirect_to new_user_session_path unless current_user
end

def authorize_user
  post = Post.find(params[:id])
  redirect_to posts_path unless current_user && current_user.id == post.user_id
end

def post_params
  params.require(:post).permit(:post_title, :image, :post_text)
end

def redirect_if_not_owner
  post = Post.find(params[:id])
  redirect_to posts_path unless current_user && current_user.id == post.user_id
end
end

