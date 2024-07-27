class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:commit] == '下書き保存'
      @post.status = 'draft'
    else
      @post.status = 'published'
    end
    if @post.save
     if @post.draft?
        redirect_to drafts_posts_path, notice: '下書きが保存されました。'
     else
        redirect_to posts_path, notice: '投稿が公開されました。'
     end
    else
      render :new
    end
  end

  def drafts
    @draft_posts = current_user.posts.drafts
  end

  def index
    @q = Post.published.ransack(params[:q])
    @posts = @q.result(distinct: true)
    if params[:tag]
      @posts = @Posts.joins(:tags).where(tags: { name: params[:tag] })
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:commit] == '下書き保存'
      @post.status = 'draft'
    else
      @post.status = 'published'
    end
    if @post.update(post_params)
     if @post.draft?
      redirect_to drafts_posts_path, notice: '下書きが更新されました。'
     else
      redirect_to posts_path, notice: '投稿が更新されました。'
     end
    else
     render :edit
    end
  end

  private

  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end

  def authorize_user
    @post = Post.find(params[:id])
    redirect_to posts_path unless current_user.id == @post.user_id
  end

  def post_params
    params.require(:post).permit(:post_title, :image, :post_text, :status, :tag_list)
  end
end