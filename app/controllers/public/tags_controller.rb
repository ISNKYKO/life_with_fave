class Public::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    unless @tag
      flash[:alert] = "タグが見つかりません。"
      return redirect_to posts_path
    end
    
    @posts = @tag.posts.published
  
    if @posts.empty?
      flash[:alert] = "このタグに関連する公開された投稿はありません。"
      redirect_to posts_path
    else
      render :show
    end
  end
end
