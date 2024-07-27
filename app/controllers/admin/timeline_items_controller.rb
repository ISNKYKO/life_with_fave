class Admin::TimelineItemsController < ApplicationController
  
  before_action :set_user

  def new
    @timeline_item = @user.timeline_items.new
  end

  def create
    @timeline_item = @user.timeline_items.new(timeline_item_params)
    if @timeline_item.save
      redirect_to @user, notice: 'タイムラインに新しい項目が追加されました。'
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def timeline_item_params
    params.require(:timeline_item).permit(:content)
  end
end
