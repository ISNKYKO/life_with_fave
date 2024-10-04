class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :destroy, :update]
  before_action :set_post, only: [:edit, :update, :destroy, :show]

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
     if @post.status == 'draft'
        redirect_to drafts_posts_path, notice: '下書きが保存されました。'
     else
        redirect_to posts_path, notice: '投稿が公開されました。'
     end
    else
      render :new
    end
  end

  def drafts
    @drafts = Post.where(status: 'draft', user_id: current_user.id).order(created_at: :desc)
    post_ids = @drafts.pluck(:id)  # 自分の下書きのIDを取得
    tag_ids = Tagging.where(post_id: post_ids).pluck(:tag_id)  # 関連するタグのIDを取得
    @tags = Tag.where(id: tag_ids)  # タグを取得
  end

  def index
    tag_ids = Tagging.where(post_id: Post.published.ids).pluck(:tag_id)
    @tags = Tag.find(tag_ids) 
    @search = Post.published.ransack(params[:q])
    @posts = @search.result(distinct: true)
    respond_to do |format|
      format.html do
        @posts = @posts.page(params[:page]).order(created_at: :desc)
      end
      format.json do
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    if @post.status == 'draft' && current_user.id != @post.user_id
      redirect_to posts_path
    end
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
  
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:post_title, :image, :post_text, :status, :tag_list, :address)
  end
  
  
end