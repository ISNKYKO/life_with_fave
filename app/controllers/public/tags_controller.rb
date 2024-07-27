class Public::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts
  end
end
